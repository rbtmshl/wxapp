class PictographsController < ApplicationController
  before_filter :signed_in_user

  def create
    @pictograph = current_user.pictographs.build(params[:pictograph])
    if @pictograph.save
      flash[:success] = "Picture Uploaded!"
      redirect_to root_url
    else
      flash[:error] = "Whoops!"
    end
  end

  def destroy
  end
end

