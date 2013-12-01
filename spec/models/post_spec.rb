require 'spec_helper'

describe Post do
  it 'should validate the presence of title' do
    post = Post.new(body: 'test')
    post.should_not be_valid
  end

  it 'should validate the presence of body' do
    post = Post.new(title: 'test')
    post.should_not be_valid
  end
end
