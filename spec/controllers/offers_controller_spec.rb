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
    before do
      get :show, params: { id: 1 }
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response).to render_template(:show) }
  end
end
