require 'json'

module Infobeep
  class SMSLogRequest < BaseRequestModel
    attribute :from, String
    attribute :to, String
    attribute :bulkId, String
    attribute :messageId, String
    attribute :generalStatus, String
    attribute :sentSince, DateTime
    attribute :sentUntil, DateTime
    attribute :limit, Integer
    attribute :mcc, String
    attribute :mnc, String

    def http_method
      :get
    end

    def route
      'logs'
    end

    def response_class
      SMSLOGSRESPONSE
    end
  end
end