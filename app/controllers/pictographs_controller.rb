class PictographsController < ApplicationController
  before_filter :signed_in_user, only: [:new, :create, :destroy, :vote]
  before_filter :correct_user,   only: :destroy

  def new
    @pictograph = Pictograph.new
  end

  def create
    @pictograph = current_user.pictographs.build(params[:pictograph])
    if @pictograph.save
      flash[:success] = "Picture Uploaded!"
      redirect_to @pictograph
    else
      render 'new'
    end
  end

  def show
    @pictograph = Pictograph.find(params[:id])
    @piccomment = @pictograph.piccomments.build
    @piccomments = @pictograph.piccomments.paginate(page: params[:page])
  end

  def destroy
    Pictograph.find(params[:id]).destroy
    redirect_to galleries_path
  end

  def vote
    value = params[:type] == "up" ? 1 : -1
    @pictograph = Pictograph.find(params[:id])
    @pictograph.add_or_update_evaluation(:votes, value, current_user)
    redirect_to :back, notice: "Thank you for voting!"
  end
  


  private

  def correct_user
    @pictograph = current_user.pictographs.find_by_id(params[:id])
    redirect_to root_path if @pictograph.nil? unless current_user.admin?
  end  

  def admin_user
      redirect_to(root_path) unless current_user.admin?
  end 
end

