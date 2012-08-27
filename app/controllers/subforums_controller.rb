class SubforumsController < ApplicationController
  before_filter :signed_in_user,     only: :create
  before_filter :admin_user,     only: :create

  def new
    @subforum = Subforum.new
  end

  def create
    @subforum = Subforum.new(params[:subforum])
    if @subforum.save
      flash[:success] = "Subforum Created!"
      redirect_to forums_path
    else
      render 'new'
      flash[:error] = "Something went awry!"
    end
  end
  
  def show
    @subforum = Subforum.find(params[:id])
    # @threads = @subforum.threads.paginate(page: params[:page])
  end

  private

   def admin_user
      redirect_to(root_path) unless current_user.admin?
   end 

end