require 'httparty'
module YoutubeEmbed
  class VideoDetails < VideoObject
    include HTTParty
    format :xml

    VALID_METHODS = [:comments, :id, :published, :updated, :category, :title, :content, :link,
                     :where, {:group => [:category, :content, :description, :keywords,
                                         :player, :thumbnail, :title]}]

    def initialize video_details
      @dynamic_methods = {}
      @id = video_details.respond_to?(:keys) ? video_details["id"].split("/").last : video_details
      @entry = (video_details if video_details.respond_to?(:keys))
    end

    def id
      @id
    end

    def dynamic_methods
      h={};@dynamic_methods.each {|k,v| h[v.class].nil? ? h[v.class]=[k] : h[v.class] << k}
      return h
    end

    def entry
      @entry ||= self.class.get_youtube(@id)["entry"]
      if @dynamic_methods.blank?
        VALID_METHODS.each {|key| recursive_hash_access @dynamic_methods, @entry, key}
        define_links
      end
      return @entry
    rescue MultiXml::ParseError
      raise InvalidVideoDetails
    end

    private

    def self.get_youtube top_route, nested_route=nil
      base_uri "https://gdata.youtube.com"
      data = get "/feeds/api/videos/#{top_route}"
    end

    def method_missing method
      (entry;@dynamic_methods[method]) if @dynamic_methods.blank?

      return self.class.get_youtube(@dynamic_methods[method].split("videos/").last)["feed"]["entry"] if [:raw_video_details_responses,:raw_related_videos].include? method
      return send("raw_#{method}").map{|v| YoutubeEmbed::VideoDetails.new(v)} if [:video_details_responses,:related_videos].include? method
      @dynamic_methods[method] || super
    end

    def define_links
      (links = [:direct_link,:video_details_responses,:related_videos,:mobile_link,:api_link]).each do |key|
        single_count = "#{key.to_s.singularize}_count".to_sym
        current_link = link[links.index(key)]["href"] if link.count>links.index(key)
        @dynamic_methods[key] = current_link
        @dynamic_methods["raw_#{key}".to_sym] = current_link
      end
    end

  end
end