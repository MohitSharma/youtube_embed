require "youtube_embed/version"
require "youtube_embed/model_additions"
require "youtube_embed/video_object"
require "youtube_embed/video_details"
require "youtube_embed/railtie" if defined? Rails
require "youtube_embed/engine"
require 'httparty'
module YoutubeEmbed

  VIDEO_FORMATS = [
      %r(https?://www\.youtube\.com/embed/(.*?)(\?|$)),
      %r(https?://youtu\.be/(.+)),
      %r(https?://www\.youtube\.com/user/.*?#\w/\w/\w/\w/(.+)\b),
      %r(https?://www\.youtube\.com/v/(.*?)(#|\?|$)),
      %r(https?://www\.youtube\.com/watch\?v=(.*?)(&|#|$))
  ]
  def self.get_video_id(url)
    url.strip!
    VIDEO_FORMATS.find { |video_format| url =~ video_format } and $1
  end

  def self.youtube_embed(data, options = {:with_description => true, :height => 200, :width => 300})
    if data.match(/https?:\/\/?(?:www\.)?youtu(?:\.be|be\.com)/)
      data = data.gsub(/<a?[^<]+ href="(?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?[a-zA-Z0-9-]{10,11}"?[^<]+>([^<]+)<\/a>/i, '\1')
      if options[:with_description]
        data = data.gsub(/((?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?[a-zA-Z0-9-]{10,11})/i, thumbnail_and_description("#{$1}", options[:width], options[:height]))
      else
        data = data.gsub(/((?:https?:\/\/)?(?:www\.)?youtu(?:\.be|be\.com)\/(?:watch\?v=)?[a-zA-Z0-9-]{10,11})/i, simple("#{$1}", options[:width], options[:height]))
      end
    end
    return data
  end

  def self.thumbnail_and_description(video_url, width, height)
    begin
      if video_url.to_s != ' '
        video_id = get_video_id(video_url)
        if video_id.present?
          video_details = YoutubeEmbed::VideoDetails.new(video_id)
          if video_details.entry !='failed'  #invalid video check
            thumbnails = video_details.thumbnail
            return %Q{<div class="youtube_embed_video">
              <div class="youtube_embed_partial_video">
                <div class="youtube_embed_thumbnail">
                  <img src="#{thumbnails[1]["url"] ? thumbnails[1]["url"] : ""}" />
                </div>
                <div class="youtube_embed_details">
                  <div class="youtube_embed_title">
                   <strong>
                     #{video_details.title["__content__"] ? video_details.title["__content__"] : ""}
                   </strong>
                  </div>
                  <div class="youtube_embed_description">
                    #{video_details.description["__content__"] ? video_details.description["__content__"].truncate(185) : ""}
                  </div>
                </div>
              </div>
              <div class="youtube_embed_main_video" style="display:none;">
                <iframe title="YouTube player" width="#{ width }" height="#{ height }" src="http://www.youtube.com/embed/#{ video_id }" frameborder="0" allowfullscreen></iframe>
              </div>
            </div>}
          else
            return video_url
          end
        else
          return video_url
        end

      end
    rescue Exception => e
      Rails.logger.debug e.message
    end
  end

  def self.simple(video_url, width, height)
    begin
      if video_url.to_s != ' '
        video_id = get_video_id(video_url)
        if video_id.present?
          return %Q{<div class="youtube_embed_video"><iframe title="YouTube player" width="#{ width }" height="#{ height }" src="http://www.youtube.com/embed/#{ video_id }" frameborder="0" allowfullscreen></iframe></div>}
        else
          return video_url
        end
    end
    rescue Exception => e
      Rails.logger.debug e.message
    end
  end

end



