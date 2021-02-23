class LikesController < ApplicationController
  before_action :find_post_or_comment
  before_action :find_like, only: [:destroy]
  # before_action :find_comment, only:[:comment_like, :comment_dislike]
  
  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @object.likes.create(user_id: current_user.id, status: 1)
    end
    if @object.class.name == 'Comment'
      @object = @object.post
    end
    redirect_to post_path(@object)
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    if @object.class.name == 'Comment'
      @object = @object.post
    end
    redirect_to post_path(@object)
  end
  
  private

  def find_post_or_comment
    if params[:post_id]
      @object = Post.find(params[:post_id])
    else
      @object = Comment.find(params[:comment_id])
    end
  end

  def find_like
    @like = @object.likes.find(params[:id])
  end

  def already_liked?
    if params[:post_id]
      Like.where(user_id: current_user.id, likeable_type: 'Post', likeable_id: params[:post_id]).exists?
    else
      Like.where(user_id: current_user.id, likeable_type: 'Comment', likeable_id: params[:comment_id]).exists?
    end
  end
end
