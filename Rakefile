require 'rake'
require 'fileutils'
require 'model'
require 'iconv'
ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')


task :default => :import

desc "Import"
task :import do
  File.open("data.txt", 'r').each_with_index do |line, line_number|
  next unless line_number > 1
  fields = line.split("|").collect { |l| l.strip }
  unless fields[7].blank?
    Hotel.create(:hotel_id => fields[0], :name => ic.iconv(fields[1]), :location => ic.iconv("#{fields[6]}, #{fields[7]}"), :raw_price => fields[13])
  end
  end
end
