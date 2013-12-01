class Blog::PostsController < ApplicationController
  def index
    @posts = Post.all
  end
end
