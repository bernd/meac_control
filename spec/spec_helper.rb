require 'pathname'
require 'rubygems'
require 'spec'

SPEC_ROOT = Pathname(__FILE__).dirname.expand_path
$:.unshift File.join(SPEC_ROOT.parent, 'lib')
