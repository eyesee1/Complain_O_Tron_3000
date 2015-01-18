class AddLocationDisplay < ActiveRecord::Migration
  def self.up
    add_column :complaints, :location_display, :string
  end

  def self.down
    remove_column :complaints, :location_display
  end
end
