class AddLocationOtherField < ActiveRecord::Migration
  def self.up
    # in case geonames doesn't get a hit, allow for a way to store what the user typed
    add_column :complaints, :other_location, :string
  end

  def self.down
    remove_column :complaints, :other_location
  end
end
