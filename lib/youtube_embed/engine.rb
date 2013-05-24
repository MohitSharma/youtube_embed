module YoutubeEmbed
  class Engine < ::Rails::Engine
    initializer 'youtube_embed.load_static_assets' do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/vendor"
    end
  end
end
