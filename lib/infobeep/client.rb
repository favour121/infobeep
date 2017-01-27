require 'base64'
require 'json'
require 'rest-client'

module Infobeep

  class BaseClient
    API_BASE_URL = 'https://api.infobip.com/'

    def initialize(username, password)
      @username = username
      @password = password
    end

    def authentication_headers
      auth_string = ::Base64.encode64("#{@username}:#{@password}").strip
      {'Authorization': "Basic #{auth_string}"}
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


  class SMSClient < BaseClient
    SMS_API_BASE_URL = "#{API_BASE_URL}sms/1/"

    def send_request(sms_request)
      url = SMS_API_BASE_URL + sms_request.route
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

  end

end