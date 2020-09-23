# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::OffersController, type: :controller do
  describe 'GET index' do
    before do
      get :index
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'POST create' do
    before do
      post :create
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'PUT/PATCH update' do
    before do
      patch :update, params: {
        id: 1
      }
    end

    it { expect(response).to have_http_status(:no_content) }
  end

  describe 'PUT/PATCH update' do
    before do
      delete :destroy, params: {
          id: 1
      }
    end

    it { expect(response).to have_http_status(:no_content) }
  end
end
