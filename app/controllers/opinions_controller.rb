class OpinionsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])

    # grab opinions on post, create new opinion on post
    opinion = @post.opinions.create((params[:opinion]).permit(:name, :opinion))

    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @opinion = @post.opinions.find(params[:id])
    @opinion.destroy
    redirect_to post_path(@post)
  end

end
