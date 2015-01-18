class AddLocationFieldsToComplaint < ActiveRecord::Migration
  def self.up
    add_column :complaints, :location_entry, :string
    add_column :complaints, :city, :string
    add_column :complaints, :state, :string
    add_column :complaints, :country, :string
    add_column :complaints, :zip, :string
    add_column :complaints, :latitude, :float
    add_column :complaints, :longitude, :float
    remove_column :complaints, :geonameId
    remove_column :complaints, :other_location
    Complaint.new do |c|
      c.complaint = "I live in the city and I can't see the stars."
      c.location_entry = 'Chicago, IL, US'
      c.save
    end
    Complaint.new do |c|
      c.complaint = "nobody ever throws the ball to me"
      c.location_entry = 'Chicago, IL, US'
      c.save
    end
  end

  def self.down
    remove_column :complaints, :location_entry
    remove_column :complaints, :city
    remove_column :complaints, :state
    remove_column :complaints, :country
    remove_column :complaints, :zip
    remove_column :complaints, :latitude
    remove_column :complaints, :longitude
    add_column :complaints, :geonameId, :integer
    add_column :complaints, :other_location, :string
  end
end
