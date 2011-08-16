require 'contrails/process'
module Contrails
  module Utils
    def trail(&block)
      return Contrails::Process.new(&block)
    end

    def seq(*ps)
      return ps.inject {|m,n| m.bind(n) }
    end

    def par(*ps)
      return ps.inject {|m,n| m.distribute(n)}
    end
  end
end
