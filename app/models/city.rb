class City < ApplicationRecord
  attr_accessor :distance

  validates :longitude, :latitude, numericality: true
  validates :country, :capital, presence: true

  def keywords
    [self.capital, self.country].compact
  end
end
