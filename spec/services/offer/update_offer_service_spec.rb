# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offer::UpdateOfferService do
  describe '#call side effects' do
    let(:offer) do
      Offer::CreateOfferService.new(advertiser_name: 'Foo Ltda.', url: 'http://foo.com/buy_it', description: 'lorem ipsum dolor sit amet. lorem ipsum dolor sit amet.', starts_at: Time.now.utc).call.result
    end
    before { use_case.call }

    context 'invalid attributes' do
      let(:use_case) { Offer::UpdateOfferService.new(offer, url: 'www.wrong_link') }

      describe '#success' do
        it { expect(use_case.success?).to be false }
      end

      describe '#result' do
        it { expect(use_case.result).to_not have_attributes(url: 'www.wrong_link') }
      end

      describe '#errors' do
        it { expect(offer.errors.messages).to eql(url: ['must be valid url']) }
      end
    end

    context 'valid attributes' do
      let(:use_case) { Offer::UpdateOfferService.new(offer, url: 'http://other_link.com') }

      describe '#success' do
        it { expect(use_case.success?).to be true }
      end

      describe '#result is a offer updated' do
        it {
          expect(use_case.result).to have_attributes(
            url: 'http://other_link.com'
          )
        }
      end
    end
  end
end
