module ApplicationHelper


  # Let's Use Markdown Biatches
  def markdown(text)
    renderer = Redcarpet::Render::SmartyHTML
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

  def rubypants(text)
    RubyPants.new(text).to_html.html_safe
  end

  def avatar_url(user)
    gravatar_url(user)
  end

  def gravatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)

    "http://gravatar.com/avatar/#{gravatar_id}.png?s=300&r=pg"
  end

  def admin_signed_in?
    signed_in? && current_user.admin?
  end

  def member_signed_in?
    signed_in? && current_user.member?
  end

end
