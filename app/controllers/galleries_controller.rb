class GalleriesController < ApplicationController
  before_filter :signed_in_user,     only: :create
  before_filter :admin_user,     only: :create

  def create
    @gallery = Gallery.new(params[:gallery])
    if @gallery.save
      redirect_to(root_path)
      flash[:success] = "Gallery Created!"
    else
     flash[:error] = "Whoops!" 
    end
  end

  def index
    @galleries = Gallery.paginate(page: params[:page])
    @pictograph = current_user.pictographs.build if signed_in?
  end

  def show
    @gallery = Gallery.find(params[:id])
    @pictographs = @gallery.pictographs.paginate(page: params[:page])
  end


  private

   def admin_user
      redirect_to(root_path) unless current_user.admin?
   end 

end
