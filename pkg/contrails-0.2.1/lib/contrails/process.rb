autoload "Chainable", "contrails/chainable"
module Contrails
  class Process 
    include Chainable

    def initialize(&l)
      @lambda = l
    end

    def run(*a)
      @lambda.call(*a)
    end
  end
end
