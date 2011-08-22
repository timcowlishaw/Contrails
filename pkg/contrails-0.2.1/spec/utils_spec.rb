require 'spec_helper'
class TestImplementation
  include Contrails::Utils
end

describe Contrails::Utils do
  before(:all) do
    @ti = TestImplementation.new
  end
  describe "trail" do
    it "creates a new process with the passed block" do
      Contrails::Process.expects(:new)
      @ti.trail {|x| x+1 }
    end
  end

  describe "seq" do
    it "binds together the supplied processes" do
      p1 = mock
      p2 = mock
      p3 = mock
      intermediate = mock
      p1.expects(:bind).with(p2).returns(intermediate)
      intermediate.expects(:bind).with(p3)
      @ti.seq(p1,p2,p3)
    end
  end

  describe "par" do
    it "distributes between the supplied processes" do
      p1 = mock
      p2 = mock
      p3 = mock
      intermediate = mock
      p1.expects(:distribute).with(p2).returns(intermediate)
      intermediate.expects(:distribute).with(p3)
      @ti.par(p1,p2,p3)
    end
  end
end
