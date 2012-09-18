class StaticPagesController < ApplicationController

  def home
    require 'open-uri'
    docname = "http://www.geoplugin.net/xml.gp?ip=" + requestion.ip
    docu = Nokogiri::XML(open(docname))
    city = docu.xpath("//geoplugin_city")
    if (city[0].content.length < 2)
      @city = "Portland"
      @state = "OR"
      @lat = "45.58"
      @lon = "-122.6"
    else
      @city = city[0].content
      state = docu.xpath("//geoplugin_region")
      @state = state[0].content
      lat = docu.xpath("//geoplugin_latitude")
      @lat = lat[0].content
      lon = docu.xpath("//geoplugin_longitude")
      @lon = lon[0].content
    end

    doc_string = "http://forecast.weather.gov/MapClick.php?lat="+ @lat +"&lon="+ @lon +"&FcstType=dwml"
    doc = Nokogiri::XML(open(doc_string))
    curtemp = doc.xpath('//temperature[@type = "apparent"]/value')
    @temperature = curtemp[0].content
    @curconditions = doc.xpath('//weather-conditions[@weather-summary]').last.values.last.to_s
    @curconditionspic = doc.xpath('//icon-link').last.content.to_s
    

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
