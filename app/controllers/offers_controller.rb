# frozen_string_literal: true

class OffersController < ApplicationController
  def index
    current_time = Time.current.utc
    @offers = Offer.where(
      state: :enabled
    ).where('offers.starts_at <= ? AND (offers.ends_at > ? OR offers.ends_at = NULL)', current_time, current_time)
  end

  def show
    @offer = Offer.where(state: :enabled).find(params[:id])
  end
end
