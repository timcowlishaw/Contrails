module Contrails
  module Helpers
    class << self
      def unwrap_array(array)
        array.inject([]) {|m,n| m + n}
      end
    end
  end
end
