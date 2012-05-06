require 'rubygems'
require 'sinatra'
require 'model'
require 'haml'
require 'sass'
require 'json'
require 'open-uri'
require 'uri'

get '/' do
  redirect params[:name] if params[:name]
  popular
  @page_title = "Damn Cheap Hotels - #{cheap_words[0..1].join(" and ")}"
  @title = "Damn Cheap Hotels"
  @location = 'Las Vegas, NV'
  @hotels = Hotel.find_cheapest
  cache_control
  haml :index
end

get '/:location' do
  cache_control
  @location = params[:location]
  @hotels = Hotel.find_by_location(@location)
  popular
  @page_title = "#{@location} #{cheap_heading} - Top 10 cheapest hotels in #{@location} at damncheaphotels.com"
  @title = "Damn #{cheap_heading} in #{@location}"
  haml :location
end

get '/stylesheets/style.css' do
  cache_control
  headers['Content-Type'] = 'text/css; charset=utf-8'
  sass :style, :cache => true
end

get '/go/:id' do  
  redirect "http://www.jdoqocy.com/click-3612296-10537500?url=http://travel.ian.com/index.jsp?pageName=hotInfo&hotelID=#{params[:id]}&hotel=1"
end

def cheap_words
  ['Cheap Hotels', 'Cheap Hotel Reservations', 'Cheap Hotel', 'Cheap Hotel Deals', 'Cheap Hotel Prices', 'Cheap Hotel Rates']
end

def cheap_heading
  cheap_words.sort_by{ rand(srand) }.first
end

def cache_control
  headers['Cache-Control'] = 'max-age=86400, public'
end

def popular
    hotels = Hotel.random_locations.collect{|h| h.location.split(",")[0]}
    popular = ['Chicago', 	
    'Las Vegas', 
    'Miami',
    'Boston',
    'Los Angeles',
    'Atlanta',
    'San Diego',
    'Dallas',
    'San Antonio',
    'San Francisco',
    'Denver',
    'Portland',
    'Tampa',
    'Austin',
    'Nashville',
    'Seattle',
    'Virginia Beach',
    'Reno']
    @recommended = (hotels + popular).sort_by{ rand(srand) }[0..60]
end
