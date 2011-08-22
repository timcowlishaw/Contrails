require 'contrails/semaphore'
autoload "Chainable", 'contrails/chainable'
module Contrails
  class Parallel

    include Contrails::Chainable
    def initialize(*procs)
      results = []
      @procs = procs
      @semaphore = Semaphore.new(@procs.length, results)
      ps = @procs.map.with_index do |p, i|
        p = p.dup
        p.callback {|*r| results[i] = r; @semaphore.signal}
        p
      end
      internal_callback { |*a|
        ps.each {|p| EM.next_tick(lambda { p.call(*a) }) }
      }
    end

    alias_method :internal_callback, :callback
    private :internal_callback

    def callback(&b)
      @semaphore.callback(&b)
    end

    def bind(other)
      @semaphore.callback(&other)
      self
    end

    def distribute(other)
      Contrails::Parallel.new(*(@procs + [other]))
    end

    def call(*a)
      self.succeed(*a)
    end

  end
end

