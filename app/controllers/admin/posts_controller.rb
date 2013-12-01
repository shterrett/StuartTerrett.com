class Admin::PostsController < AdminsController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to blog_posts_path, success: 'Post created successfully'
    else
      flash.now[:error] = 'There was an error creating the post'
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to blog_posts_path, success: 'Post created successfully'
    else
      flash.now[:error] = 'There was an error updating the post'
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
