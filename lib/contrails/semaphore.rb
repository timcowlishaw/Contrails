require 'em/deferrable'
require 'contrails/helpers'
module Contrails
  class Semaphore
    
    include EventMachine::Deferrable

    def initialize(n, results)
      @value = n
      @results = results
      @mutex = Mutex.new
    end

    def signal
      @mutex.synchronize do
        if(@value -= 1) == 0
          self.succeed(*Contrails::Helpers.unwrap_array(@results))  
        end
      end
    end
  end
end

