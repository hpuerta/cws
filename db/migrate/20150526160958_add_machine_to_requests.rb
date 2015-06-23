class AddMachineToRequests < ActiveRecord::Migration
  def change
    add_reference :requests, :machine, index: true
  end
end
