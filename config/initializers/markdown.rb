require 'kramdown'

module Markdown
  def self.render(str)
    Kramdown::Document.new(str).to_html
  end
end
