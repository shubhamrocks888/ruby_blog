class PostsController < ApplicationController

  before_action :set_post, only: [:show, :edit, :update, :destroy]
  #before_action : authenticate_user!,except:[:show,:index]

  # GET /posts
  # GET /posts.json
  def index

    if params[:user_id]

      @posts = User.find_by_id(params[:user_id])&.posts
    else
      @posts = Post.all()
    end
    @posts = @posts || []
  end
  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = Post.new

  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    @post.user = current_user

      if @post.save
        redirect_to @post

      else
        redirect_to root_path
      end
    end


  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    if @post.user_id == current_user.id
      @post.update(post_params)
      redirect_to @post

    else
        redirect_to root_path
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])

    if @post.user_id == current_user.id
       @post.destroy
      redirect_to root_path
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      #params.fetch(:post, {})
      params.require(:post).permit(:title,:content)
    end
end
