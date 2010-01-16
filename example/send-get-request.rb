#!/usr/bin/env ruby

# Simple get request example.

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'ostruct'
require 'optparse'
require 'rubygems'
require 'meac_control'
require 'httpclient'

options = OpenStruct.new
options.commands = []

opts = OptionParser.new do |o|
  o.banner = "Usage: #{File.basename(__FILE__)} [options]"

  o.on('-i', '--ip-address IP', 'IP address of the webhost') do |value|
    options.ip = value
  end

  o.on('-d', '--device ID', 'Device id') do |value|
    options.device = MEACControl::Device.new(value)
  end

  o.on('--query-drive', 'Query wheter the AC is on or off') do
    options.commands << MEACControl::Command::Drive.request
  end

  o.on('--query-fan-speed', 'Query the AC fan speed') do
    options.commands << MEACControl::Command::FanSpeed.request
  end
end
opts.parse!

unless options.ip and options.device and !options.commands.empty?
  puts opts.banner
  puts opts.summarize
  exit 1
end

response = MEACControl::HTTP.get(options.ip, options.device, options.commands)

puts "########### get request ###########"
puts response.request.to_xml
puts ""

puts "########### get response ###########"
puts response.to_xml
puts ""
