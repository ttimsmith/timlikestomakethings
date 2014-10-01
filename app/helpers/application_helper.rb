module ApplicationHelper


  # Let's Use Markdown Biatches
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  # def avatar_url(user)
  #   user.avatar_url(:user_avatar) || gravatar_url(user)
  # end

  def gravatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)

    "http://gravatar.com/avatar/#{gravatar_id}.png?s=300&r=pg"
  end

end
