# frozen_string_literal: true

# Offer model instance
class Offer < ApplicationRecord
  validates :advertiser_name, :url, presence: true
  validates :advertiser_name, uniqueness: true
end
