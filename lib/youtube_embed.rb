require "youtube_embed/version"
require "youtube_embed/model_additions"
require "youtube_embed/railtie"
module YoutubeEmbed

  #Extract ID From Url Formats
  VIDEO_FORMATS = [
      %r(https?://www\.youtube\.com/embed/(.*?)(\?|$)),
      %r(https?://youtu\.be/(.+)),
      %r(https?://www\.youtube\.com/user/.*?#\w/\w/\w/\w/(.+)\b),
      %r(https?://www\.youtube\.com/v/(.*?)(#|\?|$)),
      %r(https?://www\.youtube\.com/watch\?v=(.*?)(&|#|$))
  ]
  def get_video_id(url)
    url.strip!
    VIDEO_FORMATS.find { |video_format| url =~ video_format } and $1
  end

  def content_from_url
    data = data.gsub(/<a?[^<]+ href="[(https?:\/\/)?(www\.)?youtube.com[^<]+]+">([^<]+)<\/a>/i, '\1')
    data = data.gsub(/https?:\/\/?(?:www\.)?youtube\.com(?:\/v\/|\/watch\?v=)([A-Za-z0-9_-]{11})/, simple('\1', 200, 200))
  end

end



