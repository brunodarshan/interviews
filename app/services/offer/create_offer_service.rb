# frozen_string_literal: true

class Offer
  class CreateOfferService < ServiceBase
    attr_reader :offer
    delegate :errors, :valid?, to: :offer
    alias result offer

    def initialize(attributes)
      @attributes = attributes
      @offer = Offer.new(attributes)
    end

    def call
      @success = @offer.save
      self
    end
  end
end
