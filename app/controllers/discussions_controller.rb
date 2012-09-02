class DiscussionsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :admin_user,   only: :destroy
  
  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = current_user.discussions.build(params[:discussion])
    if @discussion.save
      flash[:success] = "Thread created!"
      redirect_to @discussion
    else
      flash[:error] = "Something went awry!"
      redirect_to @discussion.subforum
    end
  end

  def show
    @discussion = Discussion.find(params[:id])
    @comment = @discussion.comments.build
    @comments = @discussion.comments.paginate(page: params[:page])
  end
  
  def destroy
    @discussion.destroy
    redirect_to forums_path
  end

  private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end 
    
    def correct_user
      @discussion = current_user.discussions.find_by_id(params[:id])
      redirect_to root_path if @discussion.nil?
    end  
  
end


