# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Offer::EnabilityResolutionService do
  let(:use_case) { Offer::EnabilityResolutionService.new(offer) }
  describe '#call(:enabled)' do
    before { use_case.call(:enabled) }

    context 'when current time >= ends at' do
      let(:offer) { Offer::CreateOfferService.new(advertiser_name: 'Foo Ltda.', url: 'http://foo.com/buy_it', description: 'lorem ipsum dolor sit amet. lorem ipsum dolor sit amet.', starts_at: 10.days.ago, ends_at: 2.days.ago).call.result }
      describe '#success' do
        it { expect(use_case.success?).to be false }
      end
      describe '#errors' do
        it { expect(use_case.errors.messages).to include(ends_at: ['is less than current time']) }
      end
      it 'offer disabled' do
        expect(use_case.result.disabled?).to be true
      end
    end

    context 'when current time >= ends at' do
      let(:offer) { Offer::CreateOfferService.new(advertiser_name: 'Foo Ltda.', url: 'http://foo.com/buy_it', description: 'lorem ipsum dolor sit amet. lorem ipsum dolor sit amet.', starts_at: 2.days.from_now, ends_at: 10.days.from_now).call.result }
      describe '#success' do
        it { expect(use_case.success?).to be false }
      end
      describe '#errors' do
        it { expect(use_case.errors.messages).to include(starts_at: ['still distant']) }
      end
      it 'offer disabled' do
        expect(use_case.result.disabled?).to be true
      end
    end

    context 'when ends_at ok and starts_at are ok' do
      let(:offer) { Offer::CreateOfferService.new(advertiser_name: 'Foo Ltda.', url: 'http://foo.com/buy_it', description: 'lorem ipsum dolor sit amet. lorem ipsum dolor sit amet.', starts_at: 10.days.ago, ends_at: 2.days.from_now).call.result }

      describe '#success' do
        it { expect(use_case.success?).to be true }
      end

      describe 'offer enabled' do
        it { expect(use_case.result.enabled?).to be true }
      end
    end
  end

  describe '#call(:disabled)' do
    let(:offer) { Offer::CreateOfferService.new(advertiser_name: 'Foo Ltda.', url: 'http://foo.com/buy_it', description: 'lorem ipsum dolor sit amet. lorem ipsum dolor sit amet.', starts_at: 10.days.ago).call.result }
    before { use_case.call(:disabled) }
    
    describe '#success' do
      it { expect(use_case.success?).to be true }
    end

    describe '#offer' do
      it { expect(use_case.result.disabled?).to be true }
      it { expect(use_case.result).to_not have_attribute(ends_at: nil)}
    end
  end
end
