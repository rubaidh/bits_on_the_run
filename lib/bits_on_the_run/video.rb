module BitsOnTheRun
  class Video
    def self.show(video_key)
      client = Client.new('/videos/show', :video_key => video_key)
      new(client.response)
    end

    attr_reader :key
    attr_accessor :author, :date, :description, :duration, :link, :status, :tags, :title

    def initialize(*args)
      if args.first.is_a?(REXML::Document)
        initialize_from_xml(args.first)
      else
        initialize_from_hash(*args)
      end
    end

    private
    def initialize_from_hash(params = {})
      params = params.symbolize_keys
      @key             = params[:key]
      self.author      = params[:author]
      self.date        = params[:date]
      self.description = params[:description]
      self.duration    = params[:duration]
      self.link        = params[:link]
      self.status      = params[:status]
      self.tags        = params[:tags]
      self.title       = params[:title]
    end

    def initialize_from_xml(doc)
      initialize_from_hash(
        :key         => extract_xpath(doc, "//video/@key"),
        :author      => extract_xpath(doc, "//video/author"),
        :date        => Time.at(extract_xpath(doc, "//video/date").to_i),
        :description => extract_xpath(doc, "//video/description"),
        :duration    => BigDecimal.new(extract_xpath(doc, "//video/duration")),
        :link        => extract_xpath(doc, "//video/link"),
        :status      => extract_xpath(doc, "//video/status"),
        :tags        => extract_xpath(doc, "//video/tags").split(/, */),
        :title       => extract_xpath(doc, "//video/title")
      )
    end

    def extract_xpath(doc, path)
      child = doc.elements[path]
      if child.present?
        if path.include?('@')
          child.value
        else
          child.first
        end.to_s
      else
        nil
      end
    end
  end
end