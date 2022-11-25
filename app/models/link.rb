class Link < ApplicationRecord

  # Validations
  validates_presence_of :url, :encoded_url
  validates :url, format: URI::regexp(%w(http https))
  validates_uniqueness_of :encoded_url
  validates_length_of :encoded_url, within: 3..255, on: :create, message: "too long"
end
