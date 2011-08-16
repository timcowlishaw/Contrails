Contrails - declarative concurrency for EventMachine
====================================================

Contrails is a lightweight DSL that allows concurrent processes to be specified using an intuitive, declarative syntax for execution by EventMachine. It consists of a process class that wraps a block, and can then be chained with other processes in series using the `>>` operator, and composed into a single process that executes its constituent processes in parallel using the `*` operator. A trivial example:

    Contrails::Process.new { get_an_integer_from_somewhere } >> Contrails.Process.new {|x| x*2 } * {Contrails::Process.new {|x| x * 3}  >> Contrails::Process.new {|x,y| x+y } 

This takes a number from some input, computes its multiplication by two and three in parallel, then sums both values once both computations have finished.

There's still rather a lot of unsightly syntax there, right? Perhaps even more so than before. However, if you import the Contrails::Utils module, you'll get a few other useful methods:

 * the 'trails' method is an alias for Contrails::Process.new

    `trail { get_integer } >> trail { |x| x * 3} * trail { |x| x * 2 } >> trail {|x, y| x+y }`

 * the 'seq' method sequences all its arguments

    `seq(trail, trail2, trail3) == trail >> trail2 >> trail3`

 * the 'par' method composes all its arguments in parallel

    `par(trail, trail2, trail3) == trail * trail2 * trail3`

Enjoy! Questions, comments, feature requests and patches always welcome.

![Contrails](http://github.com/likely/contrails/raw/master/contrib/contrails.jpg)

(Photo by[FrancoisRoche](http://www.flickr.com/photos/francoisroche/2563417399/ on flickr), Licence: CC BY-SA)
