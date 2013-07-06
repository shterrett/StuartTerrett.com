module Md

  class << self
    
    attr_accessor :parser
    
    def parser
      @parser || self.init_markdown
    end 
    
    def init_markdown
      Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    end

  end
  
end