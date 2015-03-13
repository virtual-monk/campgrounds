require 'httparty'
require 'sinatra'
require 'pry'
# https://github.com/SpencerCDixon/API-
# api key = a72ccb932deb3d5bc1e425bfde4cffed


def get_data
  http = "https://outdoor-data-api.herokuapp.com/api.json?api_key=a72ccb932deb3d5bc1e425bfde4cffed"
  json = HTTParty.get(http)
  json
end

get '/' do
  campsites = get_data
  erb :index, locals: { campsites: campsites }
end
