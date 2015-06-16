#config.ru - used for deploying
require 'rubygems'
require 'bundler'

Bundler.require

require './app'
require 'pry-remote'
run Sinatra::Application