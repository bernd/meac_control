require 'pathname'
require 'rubygems'
require 'spec'

SPEC_ROOT = Pathname(__FILE__).dirname.expand_path
$:.unshift File.join(SPEC_ROOT.parent, 'lib')

# Pull the shared examples.
require File.join(SPEC_ROOT, 'support', 'shared_examples')

def fixture_read(filename)
  File.read(File.join(SPEC_ROOT, 'fixtures', filename))
end
