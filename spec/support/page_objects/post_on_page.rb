class PostOnPage < PageObject::Base
  def initialize(post = nil)
    @post = post
  end

  def view_blog
    visit blog_posts_path
  end

  def view_post
    visit blog_post_path(@post)
  end

  def create(&block)
    http_login
    visit new_admin_post_path
    fill_in_form &block
    click_button 'Create Post'
    @post = Post.last
  end

  def edit(&block)
    http_login
    visit edit_admin_post_path(@post)
    fill_in_form &block
    click_button 'Update Post'
  end

  def has_title?(text)
    has_text? text
  end

  def has_body?(text)
    has_text? text
  end

  def has_success_message?(action)
    "Post has been #{action}d successfully"
  end

  private

  def fill_in_form(&block)
    PostForm.new(&block)
  end
end
