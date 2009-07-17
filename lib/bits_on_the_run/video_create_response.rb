module BitsOnTheRun
  class VideoCreateResponse
    attr_reader :key

    def initialize(*args)
      if args.first.is_a?(REXML::Document)
        initialize_from_xml(*args)
      else
        initialize_from_hash(*args)
      end
    end

    def response(filename)
      @response ||= REXML::Document.new(post(filename))

      # status = @response.elements["/response/status"].first.to_s
      # if status != "ok"
      #   raise BadResponseError.new("Error returned from Bits on the run API: #{status}")
      # end

      @response
    rescue Curl::Err::CurlError => e
      raise BadResponseError.new("HTTP communication error: #{e.message}")
    end

    private
    def post(filename)
      Curl::Easy.http_post(url, Curl::PostField.file("file", filename)) do |curl|
        curl.multipart_form_post = true
      end.body_str
    end

    def url
      "#{@protocol}://#{@address}#{@path}?#{@params.to_query}"
    end

    def initialize_from_hash(params)
      params = params.symbolize_keys

      default_params = {
        :api_format => "xml"
      }

      @key      = params[:key]
      @protocol = params[:protocol]
      @address  = params[:address]
      @path     = params[:path]
      @params   = default_params.merge(params[:params])
    end

    def initialize_from_xml(doc)
      initialize_from_hash(
        {
          :key      => extract_xpath(doc, "//video/@key"),
          :protocol => extract_xpath(doc, "//video/link/protocol"),
          :address  => extract_xpath(doc, "//video/link/address"),
          :path     => extract_xpath(doc, "//video/link/path"),
          :params   => extract_params(doc, "//video/link/query")
        }
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

    def extract_params(doc, path)
      returning Hash.new do |params|
        doc.elements[path].each do |element|
          params[element.name.to_sym] = element.text.to_s.strip if element.respond_to?(:name)
        end
      end
    end
  end
end
