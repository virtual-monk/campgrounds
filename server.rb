require 'httparty'
require 'sinatra'
require 'dotenv'
require 'pry'
Dotenv.load

def get_data
  api = ENV['API_KEY']
  http = "https://outdoor-data-api.herokuapp.com/api.json?api_key=#{api}&limit=10"
  json = HTTParty.get(http)
  json
end

def get_data2(search_string)
  api = ENV['API_KEY']
  string = search_string.gsub( '@$', '/' )
  http = "https://outdoor-data-api.herokuapp.com/api.json?api_key=#{api}#{string}"
  json = HTTParty.get(http)
  json
end

get '/' do
  campsites = get_data
  erb :index, locals: { campsites: campsites }
end

post '/' do
  state = params["state"].gsub(" ", "%20")
  activity = params["activity"].gsub(" ", "%20")

  redirect '/search/' + state + '/' + activity
end

get '/search/:state/:activity' do
  state = params[:state].gsub(" ", "%20")
  activity = params[:activity].gsub(" ", "%20")
  search_string = "&q[state_eq]=#{state}"
  search_string += "&q[activities_activity_type_name_cont]=#{activity}"
  campsites = get_data2(search_string)
  erb :index, locals: { campsites: campsites }
end

get '/:name' do
  name = params[:name].gsub(" ", "%20")
  search_string = "&q[name_eq]=#{name}"
  campsites = get_data2(search_string)
  erb :show, locals: { campsites: campsites }
end
