require 'rubygems' # Ruby -v < 2.0.0
require 'nokogiri'
require 'open-uri'

startUrl = "http://nptel.ac.in/courses/Webcourse-contents/IIT%20Kharagpur/Soft%20Engg/"
listOfPaths = Array.new
puts "Gathering data..."
i = 1
while i <= 17 do
	puts "Gathering data..."
	page = Nokogiri::XML(open(startUrl+"left_mod"+i.to_s+".html"))
	titleDown = page.xpath("//tr/td/table").to_s
	titleDown.scan(/[[:alnum:]]+\.pdf/).to_a.each {|a| listOfPaths.push a}
	puts "Starting Download"
	listOfPaths.each{|el| %x(wget #{startUrl}pdf/#{el})} #Ejecuta, uno a uno, los wgets se ejecuten.
	listOfPaths.clear
	i += 1
end
