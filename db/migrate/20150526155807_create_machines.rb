class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
    	t.string :nombre
      t.timestamps
    end
  end
end
