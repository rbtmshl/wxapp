class StaticPagesController < ApplicationController

  def home
    require 'open-uri'
    docname = "http://www.geoplugin.net/xml.gp?ip=" + request.ip
    docu = Nokogiri::XML(open(docname))
    city = docu.xpath("//geoplugin_city")
    country = docu.xpath("//geoplugin_countryName")
    if ((city[0].content.length < 2) || (country[0].content.to_s != "United States") )
      @city = "Portland, OR"
      @state = "OR"
      @lat = "45.58"
      @lon = "-122.6"
    else
      @city = city[0].content
      state = docu.xpath("//geoplugin_region") + ", " + state[0].content
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
    curconditionspic = doc.xpath('//icon-link').last.content.to_s
    if (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/few.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/34.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/nfew.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/33.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/skc.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/32.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/nskc.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/31.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/sct.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/30.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/nsct.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/29.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/bkn.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/28.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/nbkn.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/27.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/ovc.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/26.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/novc.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/26.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/wind.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/24.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/nwind.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/24.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/fg.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/20.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/nfg.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/20.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/smoke.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/19.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/fzra.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/8.png"
    elsif (curconditionspic == "http://forecast.weather.gov/images/wtf/medium/ip.png")
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/8.png"
    else
      @curconditionspic = "http://s.imwx.com/v.20120328.084208//img/wxicon/120/25.png"
    end

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
