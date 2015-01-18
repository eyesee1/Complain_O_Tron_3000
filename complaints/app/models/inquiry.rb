class Inquiry < ActiveRecord::Base
  validates_presence_of     :from, :email, :location_entry, :nature, :message
  validates_length_of       :from,    :within => 3..80
  validates_length_of       :email,   :within => 3..100
  validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  
  validate do |inquiry|
    inquiry.must_have_location
  end
  
  
  def must_have_location
    errors.add_to_base("We can't send your inquiry to the right people without a location.") if location_entry.nil? or location_entry == ''
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
