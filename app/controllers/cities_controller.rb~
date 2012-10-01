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
    @city = @place.name
    @state = @place.state
    @lat = @place.lat
    @lon = @place.lon
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
  end

  def destroy
    @city.destroy
    redirect_to root_path
  end

end


