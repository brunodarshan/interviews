# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offer do
  let(:offer) { Offer.new }
  context 'invalid' do
    before { offer.valid? }

    it '#valid returns false' do
      expect(offer.valid?).to be false
    end

    describe '#errors' do
      let(:expected_messages) do
        {
          advertiser_name: ['can\'t be blank'],
          description: ['can\'t be blank'],
          starts_at: ['can\'t be blank'],
          url: ['can\'t be blank', 'must be valid url']
        }
      end
      it { expect(offer.errors).to a_kind_of(ActiveModel::Errors) }
      it {
        expect(offer.errors.messages).to eql(expected_messages)
      }
    end
  end

  context 'valid' do
    before do
      offer.advertiser_name = 'Foo Ltda.'
      offer.url = 'http://foo.com/buy_it'
      offer.description = 'lorem ipsum dolor sit amet. lorem ipsum dolor sit amet.'
      offer.starts_at = Time.now.utc
    end

    it '#valid returns false' do expect(offer.valid?).to be true end
    it { expect(offer.errors).to be_empty }
  end
end
