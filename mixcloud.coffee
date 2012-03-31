###

This is an API wrapper for the mixcloud.com API written in CoffeeScript

http://www.mixcloud.com/developers/documentation/

# TODOs
- write README.md
- put wrapper functions in a class and create them with splats
- isolate tests
- make NPM package


copyright @rmetzler
MIT license
###

http = require 'http'
puts = require('util').puts


host = 'api.mixcloud.com'

###
# make a http request and
# call handler with the response data
###
get = (path, handler) ->
  options = 
    host: host
    port: 80
    path: path
  
  #puts "GET #{host}#{path} -> #{handler}"
  http.get options, (resp) ->
    #console.log("Response: #{resp.statusCode}")
    data = ""
    resp.on 'data', (chunk) ->
      #puts 'data'
      data += chunk
    resp.on 'end', ->
      #puts 'end'
      obj = JSON.parse(data)
      
      # if here is an exeption, check if your handler exists
      handler(obj)

###
# API methods
###
get_user = (user, handler) ->
  get "/#{user}/", handler

get_user_meta = (user, handler) ->
  get "/#{user}/?metadata=1", handler
  
get_favourites = (user, handler) ->
  get "/#{user}/favorites/", handler  

get_cloudcast = (user, cloudcast, handler) ->
  get "/#{user}/#{cloudcast}/", handler

get_tag = (tag, handler) ->
  get "/tag/#{tag}/", handler

get_artist = (artist, handler) ->
  get "/artist/#{artist}/", handler

get_track = (artist, track, handler) ->
  get "/track/#{artist}/#{track}/", handler

get_category = (category, handler) ->
  get "/categories/#{category}/", handler

get_popular = (handler) ->
  get "/popular/", handler

get_hot = (handler) ->
  get "/popular/hot/", handler

get_new = (handler) ->
  get "/new/", handler

###
# Handler
###

do_nothing = (obj) ->
  puts "do nothing"
  # do nothing

print = (obj) ->
  puts JSON.stringify obj, null, "  "


###
# Test Code
###

#print = do_nothing

###
# these are examples from the API docs
###

# get_cloudcast 'spartacus', 'party-time', print
# get_user 'spartacus', print
# get_tag 'funk', print
# get_artist 'aphex-twin', print
# get_track 'michael-jackson','everybody', print
# get_category 'ambient', print

###
# my examples
###
 
# get_user 'rmetzler', print
# get_user_meta 'rmetzler', print
# get_favourites 'rmetzler', print
# 
# get_popular print
# get_hot print

get_new print

