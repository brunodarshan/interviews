# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offer::CreateOfferService do
  describe '#call side effects' do
    before { use_case.call }

    context 'invalid attributes' do
      let(:use_case) { Offer::CreateOfferService.new({}) }
      

      describe '#success' do
        it { expect(use_case.success?).to be false }
      end

      describe '#result is a offer not persisted' do
        it { expect(use_case.result).to be_a_new(Offer) }
      end
    end

    context 'valid attributes' do
      let(:use_case) do
        Offer::CreateOfferService.new(
          advertiser_name: 'Foo Ltda.',
          url: 'http://foo.com/buy_it',
          description: 'lorem ipsum dolor sit amet. lorem ipsum dolor sit amet.',
          starts_at: Time.now.utc
        )
      end

      describe '#success' do
        it { expect(use_case.success?).to be true }
      end

      describe '#result is a offer created' do
        it { expect(use_case.result).to have_attributes(
          id: be_a_kind_of(Integer), 
          enable: be(false)) }
      end

    end
  end
end
