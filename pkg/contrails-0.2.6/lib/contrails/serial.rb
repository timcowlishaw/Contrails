require 'contrails/chainable'
module Contrails
  class Serial
    include Chainable
    def initialize(*procs)
      @procs = procs
      @procs_with_callbacks = @procs.map {|p| p && p.dup}
      @procs_with_callbacks.zip(@procs_with_callbacks[1..-1]).each do |proc1, proc2|
        if proc2
          proc1.callback {|*args| proc2.call(*args) }
        else
          proc1.callback {|*args| self.succeed(*args)}
        end
      end
    end

    def bind(other)
      Contrails::Serial.new(*(@procs + [other]))
    end
    
    def call(*args)
      @procs_with_callbacks.first.call(*args)
    end
  end
end
