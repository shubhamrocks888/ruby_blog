class CommentsController < ApplicationController

  def index
    @comment = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:body))
    @comment.user = current_user
    if @comment.save
      redirect_to post_path(@post)
    end
  end

  def edit
    
  end

  def update
    if @comment.update(comment_params)
          redirect_to post_path(@post)
    else
        render 'edit'
    end
  end

  def destroy
    comment = Comment.find_by_id(params[:id])
    post_id = comment.post_id
    if comment and current_user and comment.user_id == current_user.id
        comment.destroy
    end
      redirect_to post_path(post_id)
  end

  private
  def comment_params
      params.require(:comment).permit(:body,:post_id)
  end

end
