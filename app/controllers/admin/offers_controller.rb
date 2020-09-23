# frozen_string_literal: true

module Admin
  # Offers management
  class OffersController < ApplicationController
    def index; end

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

    def update; end

    def destroy; end

    private

    def offer_params
      params.require(:offer).permit(:advertiser_name, :url, :description, :starts_at, :ends_at, :premmium, :state)
    end
  end
end
