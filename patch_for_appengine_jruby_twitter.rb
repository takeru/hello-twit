# for 0.3.6
module OAuth
  class Consumer
    protected
    alias orig_create_http_request create_http_request
    def create_http_request(http_method, path, *arguments)
      request = orig_create_http_request(http_method, path, *arguments)
      if request["Content-Length"]=="0" && request.body
        request["Content-Length"] = request.body.length
      end
      request
    end
  end
end

# for appengine-jruby/urlfetch
module Net
  class HTTP
    alias orig_request request
    def request(req, body=nil, &block)
      if body==nil && req.body
        body = req.body
      end
      orig_request(req, body, &block)
    end
  end
end
