module ApplicationHelper
  def markdown(text)
    options = {
      filter_html: true,
      hard_wrap: true,
      space_after_headers: true,
      link_attributes: {rel: 'nofollow', target: "_blank" },
      fenced_code_blocks: true
    }

    extensions = {
      autolink: true,
      superscript: true,
      highlight: true,
      strikethrough: true,
      underline: true,
      disable_indented_code_blocks: true
    }

    renderer = Redcarpet::Render::HTML.new(options)
    markdown = Redcarpet::Markdown.new(renderer, extensions)
    markdown.render(text).html_safe
  end
end
