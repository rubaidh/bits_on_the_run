module BitsOnTheRun
  class VideoTemplate
    def self.list(video_key)
      client = Client.new('/accounts/templates/list', :video_key => video_key)
      client.response.elements["//templates"].map do |fragment|
        new(REXML::Document.new(fragment.to_s)) if fragment.respond_to?(:name)
      end.compact
    end

    attr_reader :id
    attr_accessor :default, :name, :format_name, :audio_quality
    attr_accessor :video_quality, :required, :width

    def initialize(*args)
      if args.first.is_a?(REXML::Element)
        initialize_from_xml(args.first)
      else
        initialize_from_hash(*args)
      end
    end

    def initialize_from_hash(params = {})
      params = params.symbolize_keys
      @id                = params[:id]
      self.default       = params[:default]
      self.name          = params[:name]
      self.format_name   = params[:format_name]
      self.audio_quality = params[:audio_quality]
      self.video_quality = params[:video_quality]
      self.width         = params[:width]
    end

    def initialize_from_xml(doc)
      initialize_from_hash(
        :id            => extract_xpath(doc, "//@id").to_i,
        :default       => extract_xpath(doc, "//default"),
        :name          => extract_xpath(doc, "//name"),
        :format_name   => extract_xpath(doc, "//format/name"),
        :audio_quality => extract_xpath(doc, "//quality/audio").to_i,
        :video_quality => extract_xpath(doc, "//quality/video").to_i,
        :width         => extract_xpath(doc, "//width").to_i
      )
    end

    def extract_xpath(doc, path)
      child = doc.elements[path]
      if child.present?
        if path.include?('@')
          child.value
        else
          child[0]
        end.to_s
      else
        nil
      end
    end
  end
end
