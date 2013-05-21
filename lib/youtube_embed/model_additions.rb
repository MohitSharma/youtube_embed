module YoutubeEmbed
  module ModelAdditions
    def youtube_embed(attribute, with_description)

      send(attribute).gsub(/<a?[^<]+ href="[(https?:\/\/)?(www\.)?youtube.com[^<]+]+">([^<]+)<\/a>/i, '\1')
      if with_description
        send(attribute).gsub(/https?:\/\/?(?:www\.)?youtube\.com(?:\/v\/|\/watch\?v=)([A-Za-z0-9_-]{11})/, thumbnail_and_description('\1', 200, 200))
      else
        send(attribute).gsub(/https?:\/\/?(?:www\.)?youtube\.com(?:\/v\/|\/watch\?v=)([A-Za-z0-9_-]{11})/, simple('\1', 200, 200))
      end
    end

    def self.thumbnail_and_description(video_id, width, height)
      %Q{<iframe title="YouTube player" width="#{ width }" height="#{ height }" src="http://www.youtube.com/embed/#{ video_id }" frameborder="0" allowfullscreen></iframe>}
    end

    def self.simple(video_id, width, height)
      %Q{<iframe title="YouTube player" width="#{ width }" height="#{ height }" src="http://www.youtube.com/embed/#{ video_id }" frameborder="0" allowfullscreen></iframe>}
    end

  end
end