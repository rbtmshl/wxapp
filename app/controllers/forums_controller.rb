class ForumsController < ApplicationController
  before_filter :signed_in_user,     only: :create
  before_filter :admin_user,     only: :create
  
  def new
    @forum = Forum.new
  end
   
  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      redirect_to(root_path)
      flash[:success] = "Forum Created!"
    else
     render 'new' 
    end
  end

  def index
    @forums = Forum.paginate(page: params[:page])
  end

  def show
    @forum = Forum.find(params[:id])
    # @pictographs = @gallery.pictographs.paginate(page: params[:page])
  end


  private

   def admin_user
      redirect_to(root_path) unless current_user.admin?
   end 

end
