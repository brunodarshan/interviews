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

  # To UPDATE and DELETE actions test
  let(:offer) {
    Offer::CreateOfferService.new({ advertiser_name: 'Foo Bar Co.',
      starts_at: 2.days.ago,
      url: 'https://test.com',
      description: 'lorem ipsum dolor' }).call.result
  }

  describe 'PUT/PATCH update' do
    describe 'update offer action' do
      context 'update failure' do
        before do
          patch :update, params: {
            id: offer.id, offer: {
              advertiser_name: ''
            }, query: 'update'
          }
        end
    
        it { expect(response).to render_template(:edit) }
      end

      context 'update success' do
        before do
          patch :update, params: {
            id: offer.id, offer: {
              advertiser_name: 'Luthor Coorporation'
            }, query: 'update'
          }
        end
    
        it { expect(response).to redirect_to('/admin/offers') }
      end
    end

    describe 'toggle_state action' do
      context 'failure' do
      let(:offer) { Offer::CreateOfferService.new(advertiser_name: 'Foo Ltda.', url: 'http://foo.com/buy_it', description: 'lorem ipsum dolor sit amet. lorem ipsum dolor sit amet.', starts_at: 2.days.from_now, ends_at: 10.days.from_now).call.result }

        before do
          patch :update, params: {
            id: offer.id, offer: {
              state: 'enable'
            }, query: 'toggle_state'
          }
        end

        it { expect(response).to render_template(:edit) }
      end

      context 'success' do 
        before do
          patch :update, params: {
            id: offer.id, offer: {
              state: 'enabled'
            }, query: 'toggle_state'
          }
        end

        it { expect(response).to redirect_to('/admin/offers') }
      end
    end
  end

  describe 'DELETE destroy' do
    before do
      delete :destroy, params: {
        id: offer.id
      }
    end

    it { expect(response).to have_http_status(:no_content) }
  end
end
