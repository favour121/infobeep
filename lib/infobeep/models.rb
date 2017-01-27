require 'json'

module Infobeep

  class Model
    include ::Virtus.model

    def hash_attributes
      attributes
    end
  end

  class SMSRequestDestination < Model
    attribute :messageId, String
    attribute :to, String
  end

  class Status < Model
    attribute :id, Integer
    attribute :groupId, Integer
    attribute :groupName, String
    attribute :name, String
    attribute :description, String
  end

  class Error < Model
    attribute :id, Integer
    attribute :groupId, Integer
    attribute :groupName, String
    attribute :name, String
    attribute :description, String
    attribute :permanent, Boolean
  end

  class Price < Model
    attribute :pricePerMessage, BigDecimal
    attribute :currency, String
  end

  class SMSResponseDetail < Model
    attribute :to, String
    attribute :status, Status
    attribute :smsCount, Integer
    attribute :messageId, String
  end

  class SMSResponse < Model
    attribute :bulkId, String
    attribute :messages, Array[SMSResponseDetail]
  end

  class SentSMSLog < Model
    attribute :bulkId, String
    attribute :messageId, String
    attribute :to, String
    attribute :from, String
    attribute :text, String
    attribute :sentAt, DateTime
    attribute :doneAt, DateTime
    attribute :smsCount, Integer
    attribute :mccmnc, String
    attribute :price, Price
    attribute :status, Status
    attribute :error, Error

  end

  class SentSMSReport < Model
    attribute :bulkId, String
    attribute :messageId, String
    attribute :to, String
    attribute :from, String
    attribute :text, String
    attribute :sentAt, DateTime
    attribute :doneAt, DateTime
    attribute :smsCount, Integer
    attribute :mccMnc, String
    attribute :price, Price
    attribute :status, Status
    attribute :error, Error
  end

  class SMSLOGSRESPONSE < Model
    attribute :results, Array[SentSMSLog]
  end

  class SMSReportResponse < Model
    attribute :results, Array[SentSMSLog]
  end

end