class ForecastsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user,   only: :destroy
  
  def create
    @forecast = current_user.forecasts.build(params[:forecast])
    if @forecast.save
      flash[:success] = "Forecast created!"
      redirect_to root_path
    else
      @feed_items = []
      flash[:error] = "All forecast fields must be filled, you fucktard!"
      redirect_to root_path
    end
  end

  def destroy
    @forecast.destroy
    redirect_to root_path
  end

  private

    def correct_user
      @forecast = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @forecast.nil?
    end  
  
end

