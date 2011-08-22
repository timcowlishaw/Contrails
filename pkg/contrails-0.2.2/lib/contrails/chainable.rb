require 'em/deferrable'
module Contrails
  module Chainable

    def run
      raise NotImplementedError
    end

    module ClassMethods
      def return(&b)
        self.new(&b)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, EventMachine::Deferrable)
    end

    def bind(other)
      require 'contrails/serial'
      Serial.new(self, other)
    end

    def distribute(other)
      require 'contrails/parallel'
      Parallel.new(self, other)
    end

    def call(*a)
      result = run(*a)
      self.succeed(*result)
    end

    def to_proc
      lambda {|*a| self.call(*a) }
    end

    def >>(other)
      self.bind(other)
    end

    def *(other)
      self.distribute(other)
    end
    
  end
end

