#!/usr/bin/env ruby

# Simple set request example.

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

  o.on('--on', 'Turn AC on') do
    cmd = MEACControl::Command::Drive.new
    cmd.on
    options.commands << cmd
  end

  o.on('--off', 'Turn AC off') do
    cmd = MEACControl::Command::Drive.new
    cmd.off
    options.commands << cmd
  end
end
opts.parse!

unless options.ip and options.device and !options.commands.empty?
  puts opts.banner
  puts opts.summarize
  exit 1
end

xml = MEACControl::XML::SetRequest.new(options.device, options.commands)

puts "########### set request ###########"
puts xml.to_xml
puts ""

header = {'Accept' => 'text/xml', 'Content-Type' => 'text/xml'}

client = HTTPClient.new
client.protocol_version = 'HTTP/1.0'
client.agent_name = 'meac_control/1.0'
response = client.post("http://#{options.ip}/servlet/MIMEReceiveServlet", xml.to_xml, header)

puts "########### set response ###########"
puts response.content
puts ""
