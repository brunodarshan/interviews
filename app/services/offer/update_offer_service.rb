# frozen_string_literal: true

class Offer
  class UpdateOfferService < ServiceBase
    attr_reader :offer
    delegate :errors, :valid?, to: :offer
    alias result offer

    def initialize(offer, attributes)
      @attributes = attributes
      @offer = offer
    end

    def call
      @success = @offer.update(@attributes)
      @offer.reload # ensure database model state
      self
    end
  end
end
