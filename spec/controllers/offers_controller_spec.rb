# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OffersController, type: :controller do
  describe '#index GET' do
    before do
      get :index
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template(:index) }
  end

  describe '#index GET' do
    let!(:offer) do 
      Offer.create(
        advertiser_name: 'Foo Bar Corp.',
        url: 'https://google.com',
        description: 'lorem ipsum dolor',
        starts_at: 2.days.ago,
        ends_at: 2.days.from_now,
      )
    end
    before do
      offer.enabled!
      get :show, params: { id: offer.id }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template(:show) }
  end
end
