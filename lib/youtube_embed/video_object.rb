module YoutubeEmbed
  class VideoObject
    def recursive_hash_access dynamic_methods, base, key
      if key.respond_to? :keys
        key.each do |k,v|
          recursive_hash_access(dynamic_methods, base, k)
          v=[v] unless v.kind_of?(Array)
          v.each do |v1|
            recursive_hash_access(dynamic_methods, base[k.to_s.camelcase(:lower)], v1)
          end
        end
      else
        value = base[key.to_s.camelcase(:lower)]
        begin
          value = value.number? ? value.to_i : Date.parse(value)
        rescue
        end
        dynamic_methods[key] = value
      end
    end
  end
end