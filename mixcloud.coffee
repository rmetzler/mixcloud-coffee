http = require 'http'
puts = require('util').puts


host = 'api.mixcloud.com'
base_url = "http://#{host}"
cloudcast_url=''
tag_url=''
track_url=''
category_url=''

get = (path, fun) ->
  options = 
    host: host
    port: 80
    path: path
  
  puts "GET #{host}/#{path}"
  http.get options, (resp) ->
    #console.log("Response: #{resp.statusCode}")
    data = ""
    resp.on 'data', (chunk) ->
      #puts 'data'
      data += chunk
    resp.on 'end', ->
      #puts 'end'
      fun(JSON.parse(data))

print = (obj) ->
  puts JSON.stringify obj

get_user = (user, fun) ->
  get "/#{user}/", fun

get_user_meta = (user, fun) ->
  get "/#{user}/?metadata=1", fun
  

get_favourites = (user, fun) ->
  get "/#{user}/favorites/"  


get_cloudcast = (user, cloudcast, fun) ->
  get "/#{user}/#{cloudcast}/", fun

get_tag = (tag, fun) ->
  get "/tag/#{tag}/", fun

get_artist = (artist, fun) ->
  get "/artist/#{artist}/", fun

get_track = (artist, track, fun) ->
  get "/track/#{artist}/#{track}/", fun

get_category = (category, fun) ->
  get "/categories/#{category}/", fun

get_popular = (fun) ->
  get "/popular/", fun

get_hot = (fun) ->
  get "/popular/hot/", fun



# get_cloudcast 'spartacus', 'party-time', print
# get_user 'spartacus', print
# get_tag 'funk', print
# get_artist 'aphex-twin', print
# get_track 'michael-jackson','everybody', print
# get_category 'ambient', print
# 
# puts ''
# puts '-----------'
# puts ''

#get_user 'rmetzler', print
#get_user_meta 'rmetzler', print

# Doesn't work :(
# get_favourites 'rmetzler', print

#get_popular print
#get_hot print
