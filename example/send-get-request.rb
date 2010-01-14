#!/usr/bin/env ruby

# Simple get request example.

$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'meac_control'
require 'httpclient'

host = ARGV.shift
deviceid = ARGV.shift

unless host and deviceid
  puts "Usage: #{File.basename(__FILE__)} <ip-address> <device-id>"
  exit 1
end

command = [MEACControl::Command::Drive.request, MEACControl::Command::FanSpeed.request]
device = MEACControl::Device.new(deviceid)

xml = MEACControl::XML::GetRequest.new(device, command)

puts "########### get request ###########"
puts xml.to_xml
puts ""

header = {'Accept' => 'text/xml', 'Content-Type' => 'text/xml'}

client = HTTPClient.new
client.protocol_version = 'HTTP/1.0'
client.agent_name = 'meac_control/1.0'
response = client.post("http://#{host}/servlet/MIMEReceiveServlet", xml.to_xml, header)

puts "########### get response ###########"
puts response.content
puts ""
