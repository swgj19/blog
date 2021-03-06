class PostsController < ApplicationController
# before_action :authenticate_user!

  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  # create follows create route to create new post
  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  # view rendered to update post
  def edit 
    @post = Post.find(params[:id])
  end

  # method to edit post
  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    # destroy opinions associated with posts
    @post = Post.find(params[:id])
    @opinion = @post.opinions.where(post_id: @post.id)
    @opinion.each do |opinion|
      opinion.destroy
    end

    @post.destroy

    redirect_to posts_path
  end

  private

  def post_params
    params.required(:post).permit(:title, :content)
  end

end
