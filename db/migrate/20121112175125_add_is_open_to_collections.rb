class AddIsOpenToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :is_open, :boolean, default: false
  end
end
