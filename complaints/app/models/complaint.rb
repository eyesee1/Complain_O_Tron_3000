require 'yahoo/geocode'
class Complaint < ActiveRecord::Base
  validates_presence_of :complaint
  
  validate do |complaint|
    complaint.must_have_location
  end
  
  
  def must_have_location
    errors.add_to_base("We can't send your complaint to the right people without a location.") if location_entry.nil? or location_entry == ''
  end
  
  
  def nice_location
    if self.city
      return self.city + ', ' + self.state + ', ' + self.country
    else
      return self.location_entry
    end
  end
  
  def geocode_css
    if self.city
      return "geocoded"
    end
    return "notGeocoded"
  end
  def geocoded?
    if self.city
      return true
    end
    return false
  end
end
