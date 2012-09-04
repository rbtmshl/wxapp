class StaticPagesController < ApplicationController

  def home
    require 'open-uri'
    doc = Nokogiri::XML(open("http://w1.weather.gov/xml/current_obs/KSEA.xml"))
    temperature_string = doc.xpath("//temperature_string")
    @temperature = temperature_string[0].to_s
    @city = requestion.location.city
    @lat = requestion.location.lat
    @lon = requestion.location.lon
    if signed_in?
      @micropost  = current_user.microposts.build
      @forecast  = current_user.forecasts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      @ffeed_items = current_user.ffeed.paginate(page: params[:page], per_page: 10)
    end
  end
  
  def help
  end

  def about
  end

  def contact
  end
end
