# frozen_string_literal: true

module Admin
  # Offers management
  class OffersController < ApplicationController
    before_action :set_offer, only: %i[edit update destroy]
    def index
      @offers = Offer.all.order(starts_at: :asc)
    end

    def new; end

    def create
      service = Offer::CreateOfferService.new(offer_params).call

      if service.success?
        return redirect_to admin_offers_url
      else
        @offer = service.result
      end

      render :new
    end

    def update
      service = case params[:query]
                when 'update'
                  Offer::UpdateOfferService.new(@offer, offer_params.to_h).call
                when 'toggle_state'
                  Offer::EnabilityResolutionService.new(@offer).call(offer_params[:state].to_sym)
                end            
      return redirect_to admin_offers_url if service.success?

      @offer = service.result

      render :edit
    end

    def destroy; end

    private

    def set_offer
      @offer = Offer.find(params[:id])
    end

    def offer_params
      params.require(:offer).permit(:id, :advertiser_name, :url, :description, :starts_at, :ends_at, :premmium, :state)
    end
  end
end
