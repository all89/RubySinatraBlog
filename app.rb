#app.rb - the blog app main controller.

require 'sinatra'
require './models/blog_model'
require './controllers/comments'
require './controllers/posts'
require './controllers/users'

require 'date'
require 'will_paginate'
require 'will_paginate/sequel'
require 'sequel/extensions/pagination'
require 'sinatra/flash'
require 'sinatra/redirect_with_flash'
require "pry"
require "pry-remote"
require 'utils'
require 'rack'

#Helpers
helpers do
  def title
    if @title
        "#{@title}"
    else
        "|| TechX ||"
    end
  end
  #The date and time is formatted for later use.
  def date_format(time)
    time.strftime("%d %b %Y %R")
  end
  #Escaping HTML
  include Rack::Utils
  alias_method :h, :escape_html
end