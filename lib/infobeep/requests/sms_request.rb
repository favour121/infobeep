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
      h.delete(:bulkId)
      h.delete(:messages)
      h.delete(:destinations)
      h.delete(:notifyUrl)
      h.delete(:notifyContentType)
      h.delete(:callbackData)
      h.delete(:intermediateReport)
      h
    end

    def route
      'sms/2/text/single'
    end

    def payload
      hash_attributes.to_json
    end

    def http_method
      :post
    end
    
    def response_class
      SMSResponse
    end

  end
end