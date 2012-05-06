require 'dm-core'
require 'dm-validations'
require 'dm-timestamps'
require 'exceptional'

use Rack::Exceptional, '5af4811ce667c182346bfc49bf2d9f01c06562ec'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "mysql://root@localhost/damncheap") 

class Hotel
  include DataMapper::Resource
  attr_accessor :review, :review_link

  property :id,         Integer, :serial => true
  property :hotel_id,   Integer
  property :name,       String
  property :location,   String, :index => true
  property :raw_price,  Float, :index => true

  def self.random_locations
    self.all(:conditions => { :raw_price.gt => 1, :raw_price.lt => 130 }, :limit => 20).sort{rand(srand)}[0..20]
  end

  def price
    raw_price.to_s.split('.')[0]
  end
  
  def self.find_cheapest
    Hotel.all(:order => [:raw_price.asc], :raw_price.gt => 1, :limit => 10)
  end
 
  def self.find_by_location(location)
    Hotel.all(:location.like => "%#{location}%", :order => [:raw_price.asc], :raw_price.gt => 1, :raw_price.lt => 130, :limit => 10)
  end
  
end

DataMapper.auto_upgrade!