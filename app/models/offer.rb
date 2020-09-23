# frozen_string_literal: true

# Offer model instance
class Offer < ApplicationRecord
  validates :advertiser_name, :url, :description, :starts_at, presence: true
  validates :advertiser_name, uniqueness: true
  validates :description, length: { maximum: 500 }
  validates :url, format: { with: URI::DEFAULT_PARSER.make_regexp, message: 'must be valid url' }

  enum state: %i[enabled disabled]

  after_initialize do
    # ever is disabled when offer created
    self.state = :disabled unless persisted?
  end
end
