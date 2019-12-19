class StationsController < ApplicationController
  def new
    @city = Station.new
  end

  def create
    @station = Station.new(params[:station])
    if @station.save  
      flash[:success] = "Word Up!"
      redirect_to @station
    else
      render 'new'
    end
  end

  def show
    @place = Station.find(params[:id])
    @cityy = @place.city
    @state = @place.state
    @lat = @place.lat
    @lon = @place.lon
    @forecastdays = 4
    doc_string = "http://forecast.weather.gov/MapClick.php?lat="+ @lat +"&lon="+ @lon +"&FcstType=dwml"
    doc = Nokogiri::XML(open(doc_string))
    curtemp = doc.xpath('//temperature[@type = "apparent"]/value')
    @temperature = nil
    @temperature = curtemp[0].content unless curtemp[0].nil?
    if @temperature.nil?
      curtemp = doc.xpath('//temperature[@type = "air"]/value')
      @temperature = curtemp[0].content unless curtemp[0].nil?
      @forecastdays = 3;
    end
    # @curconditions = doc.xpath('//weather-conditions[@weather-summary]').last.values.last.to_s
    curconditionspic = doc.xpath('//icon-link').last.content.to_s unless doc.xpath('//icon-link').last.nil?
    @curconditionspic = weather_icon(curconditionspic)
    hi_temp = doc.xpath('//temperature[@type = "maximum"]/value')
    @hi_temp = hi_temp
    lo_temp = doc.xpath('//temperature[@type = "minimum"]/value')
    @lo_temp = lo_temp
    icons = doc.xpath('//conditions-icon[@type = "forecast-NWS"]/icon-link')
    @icons = ["",""]
    (0..icons.length-1).each do |i|
      @icons[i] = weather_icon_small(icons[i].content)
    end
    @day = doc.xpath('//time-layout/start-valid-time/@period-name')

    # observation site info
    @osname = doc.xpath('//data[@type = "current observations"]/location/area-description').first.content
    @oslat = doc.xpath('//data[@type = "current observations"]/location/point/@latitude').first.content
    @oslon = doc.xpath('//data[@type = "current observations"]/location/point/@longitude').first.content
    @oselevation = doc.xpath('//data[@type = "current observations"]/location/height').first.content
  end

  def destroy
    @station.destroy
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