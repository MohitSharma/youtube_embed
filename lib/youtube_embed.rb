require "youtube_embed/version"

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

  def self.thumbnail_and_description(video_id, width, height)
    %Q{<iframe title="YouTube player" width="#{ width }" height="#{ height }" src="http://www.youtube.com/embed/#{ video_id }" frameborder="0" allowfullscreen></iframe>}
  end

  def self.simple(video_id, width, height)
    %Q{<iframe title="YouTube player" width="#{ width }" height="#{ height }" src="http://www.youtube.com/embed/#{ video_id }" frameborder="0" allowfullscreen></iframe>}
  end

end
