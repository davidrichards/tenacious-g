require 'rubygems'
require 'gratr'
require 'uuid'

$:.unshift(File.dirname(__FILE__))

class TenaciousGError < StandardError; end
class NotImplemented < TenaciousGError; end

# Get the class Overrides
Dir.glob("#{File.dirname(__FILE__)}/tenacious_g/overrides/*.rb").each { |file| require file }


# Lazy way to get the order right: require explicitly the ones I need
# first, then require everything again. 
require 'tenacious_g/tainting_methods'

# Get the first-level files for the application.  
Dir.glob("#{File.dirname(__FILE__)}/tenacious_g/*.rb").each { |file| require file }

GRATR::Digraph.send(:include, TenaciousG::Persistence)
GRATR::UndirectedGraph.send(:include, TenaciousG::Persistence)
GRATR.send(:extend, TenaciousG::Persistence::ClassMethods)