class CitiesController < ApplicationController

  def new
    @city = City.new
  end

  def create
    @city = City.new(params[:city])
    if @city.save  
      flash[:success] = "Word Up!"
      redirect_to @city
    else
      render 'new'
    end
  end

  def show
    @place = City.find(params[:id])
    @cityy = @place.name
    @state = @place.state
    @lat = @place.lat
    @lon = @place.lon
    doc_string = "http://forecast.weather.gov/MapClick.php?lat="+ @lat +"&lon="+ @lon +"&FcstType=dwml"
    doc = Nokogiri::XML(open(doc_string))
    curtemp = doc.xpath('//temperature[@type = "apparent"]/value')
    @temperature = curtemp[0].content
    @curconditions = doc.xpath('//weather-conditions[@weather-summary]').last.values.last.to_s
    curconditionspic = doc.xpath('//icon-link').last.content.to_s
    @curconditionspic = weather_icon(curconditionspic)

    doc_string = "http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?listLatLon=" + @lat + "," + @lon + "&format=24+hourly&numDays=7"
    doc = Nokogiri::XML(open(doc_string))
    hi_temp = doc.xpath('//temperature[@type = "maximum"]/value')
    @hi_temp = hi_temp
    lo_temp = doc.xpath('//temperature[@type = "minimum"]/value')
    @lo_temp = lo_temp
  end

  def destroy
    @city.destroy
    redirect_to root_path
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

end


