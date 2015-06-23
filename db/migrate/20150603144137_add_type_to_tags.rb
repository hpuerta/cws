class AddTypeToTags < ActiveRecord::Migration
  def change
    add_reference :tags, :type, index: true
  end
end
