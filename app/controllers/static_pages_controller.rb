class StaticPagesController < ApplicationController

  def home
    require 'open-uri'
    
    # Get user's location
    docname = "http://www.geoplugin.net/xml.gp?ip=" + request.ip
    docu = Nokogiri::XML(open(docname))
    city = docu.xpath("//geoplugin_city")
    country = docu.xpath("//geoplugin_countryName")
    if ((city[0].content.length < 2) || (country[0].content.to_s != "United States") )
      @cityy = "Portland, OR"
      @state = "OR"
      @lat = "45.58"
      @lon = "-122.6"
    else
      state = docu.xpath("//geoplugin_region")
      @cityy = city[0].content + ", " + state[0].content
      lat = docu.xpath("//geoplugin_latitude")
      @lat = lat[0].content
      lon = docu.xpath("//geoplugin_longitude")
      @lon = lon[0].content
    end

    # Get current conditions for user's location
    doc_string = "http://forecast.weather.gov/MapClick.php?lat="+ @lat +"&lon="+ @lon +"&FcstType=dwml"
    doc = Nokogiri::XML(open(doc_string))
    curtemp = doc.xpath('//temperature[@type = "apparent"]/value')
    @temperature = curtemp[0].content
    @curconditions = doc.xpath('//weather-conditions[@weather-summary]').last.values.last.to_s
    curconditionspic = doc.xpath('//icon-link').last.content.to_s
    @curconditionspic = weather_icon(curconditionspic)

    # Get forecast for user's location
    hi_temp = doc.xpath('//temperature[@type = "maximum"]/value')
    @hi_temp = hi_temp
    lo_temp = doc.xpath('//temperature[@type = "minimum"]/value')
    @lo_temp = lo_temp
        icons = doc.xpath('//conditions-icon[@type = "forecast-NWS"]/icon-link')
    @icons = ["",""]
    (0..icons.length-1).each do |i|
      @icons[i] = weather_icon_small(icons[i].content)
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

  def weatherate
    @selcity = params[:city][:id]
    if (@selcity == "") 
      redirect_to :back
      flash[:error] = "You're doing it wrong!"
    else
      redirect_to City.find(@selcity)
    end
  end

  def weather_icon(iconlink)
    if (iconlink == "http://forecast.weather.gov/images/wtf/medium/few.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/34.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nfew.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/33.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/skc.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/32.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nskc.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/31.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/sct.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/30.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nsct.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/29.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/bkn.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/28.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nbkn.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/27.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/ovc.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/26.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/novc.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/26.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/wind.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/24.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nwind.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/24.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/fg.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/20.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nfg.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/20.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/smoke.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/19.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/fzra.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/8.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/ip.png")
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/8.png"
    else
      return "http://s.imwx.com/v.20120328.084208//img/wxicon/120/25.png"
    end
  end

  def weather_icon_small(iconlink)
    if (iconlink == "http://forecast.weather.gov/images/wtf/medium/few.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/34.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nfew.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/33.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/skc.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/32.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nskc.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/31.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/sct.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/30.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nsct.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/29.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/bkn.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/28.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nbkn.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/27.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/ovc.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/26.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/novc.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/26.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/wind.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/24.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nwind.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/24.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/fg.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/20.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/nfg.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/20.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/smoke.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/19.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/fzra.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/8.png"
    elsif (iconlink == "http://forecast.weather.gov/images/wtf/medium/ip.png")
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/8.png"
    else
      return "http://s.imwx.com/v.20120328.084252/img/wxicon/70/25.png"
    end
  end
end
