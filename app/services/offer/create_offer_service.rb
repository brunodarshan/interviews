# frozen_string_literal: true

class Offer
  class CreateOfferService < ServiceBase
    attr_reader :offer
    delegate :errors, :valid?, to: :offer
    alias result offer
    alias success? success

    def initialize(attributes)
      @attributes = attributes
      @offer = Offer.new(attributes)
    end

    def call
      @offer.enable = false # 1th enability rule
      @success = @offer.save
      self
    end
  end
end
