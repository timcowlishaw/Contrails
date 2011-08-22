require 'em/deferrable'
autoload "Parallel", 'contrails/parallel'
autoload "Process", 'contrails/process'
module Contrails
  module Chainable

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
      p = Process.new(&self)
      p.callback(&other)
      return p
    end

    def distribute(other)
      Parallel.new(self, other)
    end

    def call(*a)
      self.succeed(*run(*a))
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

