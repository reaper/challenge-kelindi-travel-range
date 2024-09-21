module TravelRange
  module GreatCircle
    class Unit
      KILOMETER = 1
    end

    class Distance
      @@radius_in_kilometers = 6371

      attr_accessor :src_lat, :src_lon

      ##
      # Constructor
      def initialize(lat, lon)
        @src_lat = degree_to_radian(lat)
        @src_lon = degree_to_radian(lon)
      end

      ##
      # Compute for target latitude and longitude
      # @param lat Target latitude
      # @param lon Target longitude
      # @param unit Unit of the distance to return
      def compute(lat, lon, unit=Unit::KILOMETER)
        target_lat = degree_to_radian(lat)
        target_lon = degree_to_radian(lon)

        dist_lon = target_lon - @src_lon
        dist_lat = target_lat - @src_lat

        coef = haversine_formula(dist_lat, dist_lon, target_lat)
        case unit
        when Unit::KILOMETER then coef * @@radius_in_kilometers
        end
      end

      private

      ##
      # Haversine formula
      # https://en.wikipedia.org/wiki/Haversine_formula
      #
      # @oaram dist_lat
      # @param dist_lon
      # @param target_lat
      def haversine_formula(dist_lat, dist_lon, target_lat)
        d = (Math.sin(dist_lat / 2))**2 + Math.cos(@src_lat) *
          Math.cos((target_lat)) * (Math.sin(dist_lon / 2))**2

        (2 * Math.atan2( Math.sqrt(d), Math.sqrt(1 - d) ))
      end

      ##
      # Degree to radius
      # @param deg degree
      def degree_to_radian(deg)
        deg * (Math::PI / 180)
      end
    end
  end
end
