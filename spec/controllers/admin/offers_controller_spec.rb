# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::OffersController, type: :controller do
  describe 'GET index' do
    before do
      get :index
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'GET new' do
    before do
      get :new
    end

    it { expect(response).to have_http_status(:ok) }
  end

  describe 'POST create' do
    context 'failure' do
      before do
        post :create, params: { offer: { advertise_name: '', description: '' } }
      end

      it { expect(response).to render_template(:new) }
    end

    context 'success' do
      before do
        post :create, params: { offer: { advertiser_name: 'Foo Bar Co.',
                                         starts_at: 2.days.from_now,
                                         url: 'https://test.com',
                                         description: 'lorem ipsum dolor' } }
      end

      it { expect(response).to redirect_to('/admin/offers') }
    end
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
