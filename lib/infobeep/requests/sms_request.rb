require 'json'

module Infobeep
  class SMSRequest < BaseRequestModel
    attribute :from, String
    attribute :to, Array[String]
    attribute :destinations, Array[SMSRequestDestination]
    attribute :text, String
    attribute :notifyUrl, String
    attribute :notifyContentType, String, default: 'application/json'
    attribute :callbackData, String
    attribute :intermediateReport, Boolean, default: false


    def hash_attributes
      h = super
      h[:destinations] = []
      h[:destinations] =  h[:destinations] + destinations.collect{ |destination| destination.hash_attributes }
      unless to.empty?
        h[:destinations] << {to: to}
      end
      h.delete(:to)
      h
    end

    def route
      'text/advanced'
    end

    def http_method
      :post
    end

    def payload
      bulk_sms_request = Infobeep::BulkSMSRequest.new
      bulk_sms_request.messages = [self]
      bulk_sms_request.payload
    end

    def response_class
      SMSResponse
    end

  end
end