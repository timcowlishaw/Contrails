require 'em/deferrable'
require 'contrails/parallel'
module Contrails
  class Process
    include EventMachine::Deferrable
    include Contrails::Chainable

    class << self
      def return(&b)
        self.new(&b)
      end
    end

    def initialize(&l)
      @lambda = l
    end

    def bind(other)
      p = Contrails::Process.new(&self)
      p.callback(&other)
      return p
    end

    def distribute(other)
      Contrails::Parallel.new(self, other)
    end
    
    def call(*a)
      self.succeed(*@lambda.call(*a)) 
    end
  end
end
