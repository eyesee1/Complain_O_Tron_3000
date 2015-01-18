# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'yahoo/geocode'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem
  # You can move this into a different controller, if you wish.  This module gives you the require_role helpers, and others.
  include RoleRequirementSystem


  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery :secret => '889e062b497a061da7447b9dc130ca27'
end




def geo_lookup(location_string)
  if location_string == nil:
    return {}
  end
  apikey='NXyqcpzV34FEHjgf7LHUGoIDZ8gckPsDou20hv36gVbWaNV02gE2j6srF0CvMw--'
  yg = Yahoo::Geocode.new apikey
  begin
    results = yg.locate location_string
    if results.length > 0
      r = results[0]
      return {
        'city' => r.city,
        'state' => r.state,
        'zip' => r.zip,
        'country' => r.country,
        'longitude' => r.longitude,
        'latitude' => r.latitude
      }
    end
  rescue
    # we got nothin'
    return {}
  end
end

