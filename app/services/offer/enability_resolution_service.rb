# frozen_string_literal: true

class Offer
  class EnabilityResolutionService < ServiceBase
    attr_reader :offer
    delegate :errors, to: :offer
    alias result offer
    def initialize(offer)
      @offer = offer
    end

    def call(state)
      @success = false
      current_time = Time.current.utc
      attributes = {}
      case state
      when :enabled
        if current_time >= @offer.starts_at && current_time <= @offer.ends_at
          @success = true; attributes = { state: :enabled }
        end
        # ensure rule 3 - when current time ≤ ends at, state = disabled
        if !@offer.ends_at.blank? && current_time >= @offer.ends_at
          @offer.errors.add(:ends_at, 'is less than current time')
        end
        if current_time < @offer.starts_at
          # ensure rule 2 - when current time >= starts at, state = enabled
          @offer.errors.add(:starts_at, 'still distant')
        end
      when :disabled
        # 4 - when ends at is blank it is never disabled
        # 5 - when the admin clicks on disable it should become disabled regardless of time
        attributes = { state: :disabled, ends_at: (if @offer.ends_at.blank?
                                                      current_time
                                                    end) }.compact
        @success = true                                                      
      end
      @success ? update_service(attributes) : self
    end

    private

    def update_service(attributes)
      service = Offer::UpdateOfferService.new(@offer, attributes).call
      @offer = service.result
      @success = service.success?
    end
  end
end
