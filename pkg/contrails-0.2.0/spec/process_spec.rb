require 'spec_helper'

describe Contrails::Process do
  describe "class methods:" do
    
    describe "new" do
      it "wraps the passed lambda in a process" do
        for_all do
          int = integer
          async_assertion(Contrails::Process.new { |x| x**2 }, int) { |result|
            result.should == int**2
          }
        end
      end
    end
    
    describe "return" do
       it "delegates to the constructor method" do
         lamb = lambda {|x, y| x + y }
         Contrails::Process.expects(:new) #sadly we can't test for block arguments with mocha
         Contrails::Process.return(&lamb)
       end
    end
  end

  describe "instance methods:" do
    describe "bind" do
      it "returns a process which sequences the second operation after the first" do
        for_all do
          context = mock
          context.expects(:first).in_sequence
          context.expects(:second).in_sequence
          proc1 = Contrails::Process.new { context.first }
          proc2 = Contrails::Process.new { context.second }
          async_assertion(proc1.bind(proc2))
        end
      end
      it "successively calls other processes bound onto the argument" do
        for_all do 
          context = mock
          context.expects(:first).in_sequence
          context.expects(:second).in_sequence
          context.expects(:third).in_sequence
          proc1 = Contrails::Process.new { context.first }
          proc2 = Contrails::Process.new { context.second }
          proc3 = Contrails::Process.new { context.third }
          async_assertion(proc1.bind(proc2).bind(proc3))
        end
      end

      it "passes the return value of each process to its successors" do
        for_all do
          int= integer
          proc1 = Contrails::Process.new { |x| x.should == int; x+1}
          proc2 = Contrails::Process.new { |x| x.should == int+1; x+1}
          proc3 = Contrails::Process.new { |x| x.should == int+2; x+1}
          async_assertion(proc1.bind(proc2).bind(proc3), int) {|x| x.should == int+3}
        end
      end
    end

    describe "distribute" do
      
      it "returns a process that executes both processes, yielding the results of both as a pair" do
        for_all {
          int = integer
          proc1 = Contrails::Process.new {|x| x*2}
          proc2 = Contrails::Process.new {|x| x*3}
          async_assertion(proc1.distribute(proc2), int) {|x1, x2|
            x1.should == int*2
            x2.should == int*3
          }
        }
             end
       it "yields the return value of both to subsequently bound processes" do
          for_all {
            int = integer
            proc1 = Contrails::Process.new {|x| x*2 }
            proc2 = Contrails::Process.new {|x| x*3 }
            proc3 = Contrails::Process.new {|x,y| x + y }
            async_assertion(proc1.distribute(proc2).bind(proc3), int) {|r|
              r.should == int*2 + int*3
            }
          }
        end

      it "executes both processes in parallel" do
        for_all {
          time = float
          guard time > 0.05
          guard time < 0.25
          context = mock
          context.expects(:first).in_sequence
          context.expects(:second).in_sequence
          proc1 = Contrails::Process.new { sleep(time); context.second }
          proc2 = Contrails::Process.new { context.first }
          async_assertion(proc1.distribute(proc2))
        }
      end
      it "executes any subsequently distributed processes in parallel" do
        for_all {
          time = float
          guard time > 0.05
          guard time < 0.25
          context = mock
          context.expects(:first).in_sequence
          context.expects(:second).in_sequence
          context.expects(:third).in_sequence
          proc1 = Contrails::Process.new { sleep(time); context.third }
          proc2 = Contrails::Process.new { sleep(time/2); context.second }
          proc3 = Contrails::Process.new { context.first }
          async_assertion(proc1.distribute(proc2).distribute(proc3))
        }
      end

      it "collects the results of all processes into a single list of arguments to its callback" do
        for_all {
          int = integer
          proc1 = Contrails::Process.new {|x| x+1 }
          proc2 = Contrails::Process.new {|x| x+2 }
          proc3 = Contrails::Process.new {|x| x+3 }
          async_assertion(proc1.distribute(proc2).distribute(proc3), int) {|a|
            a.should == [int+1, int+2, int+3]
          }
        }
      end
    end

    describe "call" do
      it "calls the lambda and sets itself as succeeded, passing the blocks return value" do
        for_all do
          int = integer
          async_assertion(Contrails::Process.new { |x| x + 2}, int) { |result|
            result.should == int + 2
          }
        end
      end
    end

    describe "to proc" do
      it "returns a lambda which wraps the computation" do
        p = Contrails::Process.new { 1+2 }
        p.expects(:call)
        p.to_proc.should be_a(Proc)
        p.to_proc.call
      end
    end

    describe ">>" do
      it "delegates to the bind method" do
        proc1 = Contrails::Process.new {|x| x**2}
        proc2 = Contrails::Process.new {|x| x+1 }
        proc1.expects(:bind).with(proc2)
        proc1 >> proc2
      end
    end

    describe "*" do
      it "delegates to the distribute method" do
        proc1 = Contrails::Process.new {|x| x**2}
        proc2 = Contrails::Process.new {|x| x+1 }
        proc1.expects(:distribute).with(proc2)
        proc1 * proc2
      end
    end
  end
end
