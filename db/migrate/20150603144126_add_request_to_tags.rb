class AddRequestToTags < ActiveRecord::Migration
  def change
    add_reference :tags, :request, index: true
  end
end
