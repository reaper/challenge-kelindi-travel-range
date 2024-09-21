class CitySerializer
  include JSONAPI::Serializer
  attributes :latitude, :longitude, :country, :capital, :distance
end
