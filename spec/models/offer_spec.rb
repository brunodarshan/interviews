# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offer do
  describe '#valid?' do
    let(:offer) { Offer.new }
    context 'invalid' do
      context 'when advertiser_name and/or url are empty' do
        it { expect(offer.valid?).to be false }
      end
    end

    context 'valid' do
      before do
        offer.advertiser_name = 'Foo Ltda.'
        offer.url = 'http://foo.com/buy_it'
      end

      it { expect(offer.valid?).to be true }
    end
  end
end
