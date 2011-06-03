module ApplicationHelper
  def gravatar_url(email, size = 80)
    hash = Digest::MD5::hexdigest(email).downcase
    "http://www.gravatar.com/avatar/#{hash}?s=#{size.to_i}&d=mm"
  end
end
