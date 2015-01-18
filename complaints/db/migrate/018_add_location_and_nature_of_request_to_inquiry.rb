class AddLocationAndNatureOfRequestToInquiry < ActiveRecord::Migration
  def self.up
    add_column :inquiries, :location_entry, :string, :limit => 128
    add_column :inquiries, :city, :string, :limit => 128
    add_column :inquiries, :state, :string, :limit => 55
    add_column :inquiries, :country, :string, :limit => 3
    add_column :inquiries, :zip, :string, :limit => 30
    add_column :inquiries, :latitude, :float
    add_column :inquiries, :longitude, :float
    add_column :inquiries, :nature, :string, :limit => 55
  end

  def self.down
    remove_column :inquiries, :location_entry
    remove_column :inquiries, :city
    remove_column :inquiries, :state
    remove_column :inquiries, :country
    remove_column :inquiries, :zip
    remove_column :inquiries, :latitude
    remove_column :inquiries, :longitude
    remove_column :inquiries, :nature
  end
end
