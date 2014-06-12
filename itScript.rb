require 'rubygems' # Ruby -v < 2.0.0
require 'nokogiri'
require 'open-uri'
require 'uri'

gen = "http://"
startUrl = "http://it-ebooks.info/book/1/"

maxDownPerTime = 5
maxDownPerTime = ARGV[0] if ARGV.size > 0

# debería implemetar el bajar por tags: "it-books.info/tag/programming"

page = Nokogiri::XML(open(startUrl))
toDownload =  /filepi\.com\/i\/.+http/.match(page.xpath("//td/a/@href").to_s).to_s
toDownload.slice! "http"
toDownload = gen + toDownload #Acá tengo el link de descarga.
exec("wget --referer=#{startUrl} #{toDownload}")