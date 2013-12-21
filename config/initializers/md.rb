module Md
  class << self
    attr_accessor :parser

    def parser
      @parser || self.init_markdown
    end

    def init_markdown
      renderer = Redcarpet::Render::HTML.new(prettify: true)
      Redcarpet::Markdown.new(renderer, { fenced_code_blocks: true })
    end
  end
end
