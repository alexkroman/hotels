require 'rubygems'
require 'sinatra'
require 'hotels'
require 'rack/cache'

use Rack::Cache,
  :metastore   => 'file:/tmp/meta',
  :entitystore => 'file:/tmp/body'

log = File.new("log/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

Sinatra::Application.default_options.merge!(
  :run => false,
  :env => ENV['RACK_ENV']
)

run Sinatra::Application