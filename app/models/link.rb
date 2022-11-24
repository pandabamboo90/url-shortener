class Link < ApplicationRecord

  # Validations
  validates_presence_of :url, :slug
  validates :url, format: URI::regexp(%w(http https))
  validates_uniqueness_of :slug
  validates_length_of :slug, within: 3..255, on: :create, message: "too long"
end
