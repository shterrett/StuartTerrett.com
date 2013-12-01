class PostForm < Form::Base
  def initialize(&block)
    instance_eval &block
  end

  def title(value)
    fill_in 'post_title', with: value
  end

  def body(value)
    fill_in 'post_body', with: value
  end
end
