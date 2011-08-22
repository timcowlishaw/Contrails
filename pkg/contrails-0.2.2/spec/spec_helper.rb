$: << File.join(File.dirname(__FILE__),"..")
require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'rantly'
require 'mocha'
require 'eventmachine'
require 'em/deferrable'
require 'lib/contrails'
RSpec.configure do |config|
  config.mock_framework = :mocha
end

Rantly.send(:include, Mocha::API)

def for_all(&block)
  Rantly.each(ENV['RANTLY_LIMIT'] ? ENV['RANTLY_LIMIT'].to_i : 100, &block) 
end

class DeferrableTest
  include EventMachine::Deferrable
  def initialize(*a, &b)
    @args = a
    @lambda = b
  end

  def to_proc
    lambda { succeed(*@lambda.call(*@args)) }
  end
end

def async_assertion(process, *args, &callback)
  EM.run_block do
    deferrable = DeferrableTest.new(*args, &process)
    deferrable.callback(&callback) if callback
    EM.defer(&deferrable)
  end
end
