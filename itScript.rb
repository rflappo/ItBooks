require 'rubygems'
require 'nokogiri'
require 'open-uri'

startUrl = "http://it-books.info/book/1/"
downloadUrl = "http://filepi.com/i"
maxDownPerTime = 5
maxDownPerTime = ARGV[0] if ARGV.size > 0

# debería implemetar el bajar por tags: "it-books.info/tag/programming"

page = Nokogiri::HTML(open(startUrl))
