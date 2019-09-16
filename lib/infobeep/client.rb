require 'base64'
require 'json'
require 'rest-client'

module Infobeep

  class Client
    API_BASE_URL = 'https://26l26.api.infobip.com/'

    def initialize(key, user_id)
      @key = key
      @user = User.find(user_id)
    end

    def send_request(sms_request)
      url = API_BASE_URL + sms_request.route
      method = sms_request.http_method
      headers = client_headers.merge(sms_request.headers)
      payload = sms_request.payload

      begin
        response = RestClient::Request.execute(method: method, url: url, payload: payload, headers: headers)
      rescue RestClient::ExceptionWithResponse => err
        raise err
      end

      response_hash = JSON.parse(response.body)
      sms_request.response_class.new(response_hash)
    end

    def authentication_headers
      {'Authorization': "App #{@key}"}
    end

    def client_headers
      hsh = {
          'User-Agent': "Infobeep-#{Infobeep::VERSION}",
          'Content-Type': 'application/json',
          'accept': 'application/json'
      }
      hsh.merge!(authentication_headers)
      hsh
    end

  end

end