class PiccommentsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :admin_user,   only: :destroy
  
  def create
    @piccomment = current_user.piccomments.build(params[:piccomment])
    if @piccomment.save
      flash[:success] = "Comment uploaded!"
      redirect_to @piccomment.pictograph
    else
      flash[:error] = "Something went awry! Please correct errors and try again"
      redirect_to :back
    end
  end

  def destroy
    @piccomment.destroy
    redirect_to root_path
  end

  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end     
  
end



