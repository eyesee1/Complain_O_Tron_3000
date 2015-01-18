class GeonamesController < ApplicationController
  require 'yahoo/geocode'
  def search
    # city = params[:city_city]
    city = params[:id]
    apikey='NXyqcpzV34FEHjgf7LHUGoIDZ8gckPsDou20hv36gVbWaNV02gE2j6srF0CvMw--'
    # lookup by place name. basically just relay results from gem
    yg = Yahoo::Geocode.new apikey
    if city == nil
      return nil
    end
    puts 'search on ' + city
    results = yg.locate city
    puts 'results:' + results.to_json
    respond_to do |format|
      format.html { render :html => @results, :layout => 'geonames' }
      format.json { render :json => @results.to_json }
    end
  end
end
