module BitsOnTheRun
  class Video
    def self.show(video_key)
      client = Client.new('/videos/show', :video_key => video_key)
      new(client.response)
    end

    def self.create!(params = {})
      returning new(params) do |video|
        video.save!
      end
    end

    attr_reader :key
    attr_accessor :author, :date, :description, :duration, :link, :status
    attr_accessor :tags, :title, :filename

    def initialize(*args)
      if args.first.is_a?(REXML::Document)
        initialize_from_xml(args.first)
      else
        initialize_from_hash(*args)
      end
    end

    def templates
      @templates ||= VideoTemplate.list(key)
    end

    def save!
      client = Client.new('/videos/create',
        :title       => title,
        :tags        => tags.join(", "),
        :description => description,
        :author      => author,
        :date        => date.to_i,
        :link        => link,
        :md5         => md5,
        :size        => size
      )

      post_video = VideoCreateResponse.new(client.response)
      @key = post_video.key
      post_video.response(filename)
    end

    private

    def md5
      Digest::MD5.hexdigest data
    end

    def data
      @data ||= File.read(filename)
    end

    def size
      data.length
    end

    def initialize_from_hash(params = {})
      params = params.symbolize_keys
      @key             = params[:key]
      self.author      = params[:author]
      self.date        = params[:date]        || Time.now
      self.description = params[:description]
      self.duration    = params[:duration]    || 0
      self.link        = params[:link]
      self.status      = params[:status]
      self.tags        = params[:tags]        || []
      self.title       = params[:title]
      self.filename    = params[:filename]
    end

    def initialize_from_xml(doc)
      tags = extract_xpath(doc, "//video/tags")
      tags = tags.split(/, */) if tags.present?

      initialize_from_hash(
        :key         => extract_xpath(doc, "//video/@key"),
        :author      => extract_xpath(doc, "//video/author"),
        :date        => Time.at(extract_xpath(doc, "//video/date").to_i),
        :description => extract_xpath(doc, "//video/description"),
        :duration    => BigDecimal.new(extract_xpath(doc, "//video/duration")),
        :link        => extract_xpath(doc, "//video/link"),
        :status      => extract_xpath(doc, "//video/status"),
        :tags        => tags,
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
