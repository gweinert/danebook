class PostsController < ApplicationController

  def new
  end

  def create
    @post = current_user.posts.build(params_hash)
    if @post.save
      flash[:success] = "Posted new story!"
    else
      flash[:error] = "hit, your post didnt post, bro"
    end
    redirect_to user_posts_path(current_user)
  end

  def index
    user = User.find(params[:user_id])
    @profile = user.profile
    @posts = user.posts.order(:created_at => :DESC)
    @post = user.posts.build
    @comment = Comment.new
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      flash[:success] = "Successfully deleted post"
    else
      flash[:error] = "Failed to delete post"
    end
    redirect_to user_posts_path(current_user)
  end

  private

    def params_hash
      params.require(:post).permit(:body)
    end
end