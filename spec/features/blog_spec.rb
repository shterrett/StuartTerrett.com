require 'spec_helper'

feature 'viewing blog posts' do
  scenario 'list of posts' do
    exemplar = FactoryGirl.create(:post)
    post = post_on_page(exemplar)
    visit blog_posts_path

    post.should have_title(exemplar.title)
    post.should have_body(exemplar.body)
  end

  scenario 'creates a post' do
    post = post_on_page
    post.create do
      title 'Test blog post title'
      body 'Lorem Ipsum stuff'
    end

    post.should have_title 'Test blog post title'
    post.should have_body 'Lorem Ipsum stuff'
    post.should have_success_message(:create)
  end

  scenario 'updates a post' do
    exemplar = FactoryGirl.create(:post)
    post = post_on_page(exemplar)
    post.edit do
      title 'Edited title'
      body 'Edited body'
    end

    post.should have_title 'Edited title'
    post.should have_body 'Edited body'
    post.should have_success_message(:update)
  end
end

def post_on_page(post = nil)
  PostOnPage.new(post)
end
