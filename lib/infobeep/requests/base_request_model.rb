require 'json'

module Infobeep
  class BaseRequestModel < Model

    def payload
      if http_method == :get
        nil
      else
        hash_attributes.to_json
      end
    end

    def headers
      if http_method == :get
        {params: hash_attributes}
      else
        {}
      end
    end
  end
end