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

  it 'defaults to reverse chronological order' do
    Timecop.travel(1.day.ago) do
      @post_1 = FactoryGirl.create(:post)
    end
    Timecop.travel(2.days.ago) do
      @post_2 = FactoryGirl.create(:post)
    end

    expect(Post.all).to eq([@post_1, @post_2])
  end
end
