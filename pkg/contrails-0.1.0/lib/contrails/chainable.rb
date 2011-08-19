module Contrails
  module Chainable

    def bind(other)
      raise NotImplementedError
    end

    def distribute(other)
      raise NotImplementedError
    end

    def call(*a)
      raise NotImplementedError
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

