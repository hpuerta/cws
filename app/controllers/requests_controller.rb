class RequestsController < ApplicationController
  before_action :set_request, only: [:show, :edit, :update, :destroy]
  before_action :set_vars, only: [:new, :edit]
  before_action :authenticate_user!, only: [:edit,:destroy,:update]

  # GET /requests
  # GET /requests.json
  def index
    if !params['accion'].present?
      @requests = Request.all.order(estado: :desc) 
    elsif params['accion'] == "noLeidos"
      @requests = Request.noLeidos
    elsif params['accion'] == "Leidos"
      @requests = Request.Leidos
    elsif params['accion'] == "Pendientes"
      @requests = Request.Pendientes
    elsif params['accion'] == "Solucionados"
      @requests = Request.Solucionados
    elsif params['accion'] == "Alta"
      @requests = Request.Alta
    elsif params['accion'] == "Media"
      @requests = Request.Media
    elsif params['accion'] == "Baja"
      @requests = Request.Baja
    end
    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"requerimientos.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
    if @request.estado =="_noLeido"
      @request.estado = "Leido"
      @request.save
    end
  end

  # GET /requests/new
  def new
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
    if @request.estado =="_noLeido"
      @request.estado = "Leido"
      @request.save
    end
  end

  # POST /requests
  # POST /requests.json
  def create
    @request = Request.new(request_params)
    @request.estado = "_noLeido"
    #puts "Value=" + params[:nuevaCategoria]
    respond_to do |format|
      if @request.save
        create_extras
        format.html { redirect_to requests_path, notice: 'El requerimiento fue creado satisfactoriamente.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @request.update(request_params)
        create_extras
        format.html { redirect_to requests_path, notice: 'El requerimiento fue actualizado satisfactoriamente.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'El requerimiento fue eliminado satisfactoriamente' }
      format.json { head :no_content }
    end
  end
  def date_format(date)
     date.to_time.to_datetime.strftime("%d/%m/%Y %I:%M %p")
  end
  helper_method :date_format
  
  def autoSolicitante
    @requests = Request.order(:solicitante).where("solicitante LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @requests.map(&:solicitante)
      }
    end
  end

  def autoMail
    @requests = Request.order(:mail).where("mail LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @requests.map(&:mail)
      }
    end
  end

  def autoEjecutor
    @requests = Request.order(:ejecutor).where("ejecutor LIKE ?", "%#{params[:term]}%")
    respond_to do |format|
      format.html
      format.json { 
        render json: @requests.map(&:ejecutor)
      }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_request
      @request = Request.find(params[:id])
    end

    def set_vars
      @categories = Category.all
      @machines = Machine.all
      @types = Type.all
    end

    def create_extras
      if !(params[:nuevaCategoria] == "")
          c= Category.new()
          c.nombre =  params[:nuevaCategoria]
          if c.save
            @request.category = c
            @request.save
          end
        end
        if !(params[:nuevaMaquina] == "")
          m= Machine.new()
          m.nombre =  params[:nuevaMaquina]
          if m.save
            @request.machine = m
            @request.save
          end
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def request_params
      params.require(:request).permit(:solicitante, :descripcion, :category_id, :machine_id, :importancia, :mail, { :type_ids => [] },:partemaquina, :descripcionNoRealizado, :fechaEstimada, :descripcionEjecucion, :fechaHoraInicio, :fechaHoraFin, :ejecutor, :descripcionPendiente, :estado)
    end
    #MECANICO ELECTRICO-ELECTRONICO OPERATIVO LOCATIVO
end