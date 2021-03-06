class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
    return head(:forbidden) unless current_user.admin? || current_user.vip? || current_user.try(:id) == @post.id
    @post.update(post_params)
    redirect_to post_path, :notice => "post updated"
  end
  
  def destroy 
  	post = Post.find(params[:id])
  	return head(:forbidden) unless current_user.admin? || current_user.try(:id) == post.id
  	redirect_to posts_path, :notice => "post deleted"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:content, :id)
    end
    
    
    
    
    
end
