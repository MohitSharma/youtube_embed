module YoutubeEmbed
  module ModelAdditions
    def youtube_embed(attribute, options)
      before_validation do
        send("#{attribute}=", YoutubeEmbed.youtube_embed(send(attribute), options))
      end
    end

  end
end