class AddGeoNameId < ActiveRecord::Migration
  def self.up
    add_column :complaints, :geonamesId, :integer
  end

  def self.down
    remove_column :complaints, :geonamesId
  end
end
