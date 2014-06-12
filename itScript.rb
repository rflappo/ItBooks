require 'rubygems' # Ruby -v < 2.0.0
require 'nokogiri'
require 'open-uri'
require 'uri'

gen = "http://"
startUrl = "http://it-ebooks.info/book/"

maxDownPerTime = 5
maxDownPerTime = ARGV[0] if ARGV.size > 0
# debería implemetar el bajar por tags: "it-books.info/tag/programming"

threadHandler = Array.new
listOfPaths = Array.new
i = 1
page = Nokogiri::XML(open(startUrl+i.to_s))
titleDown = page.xpath("//head/title").to_s


while (i < 5 and titleDown != "<title>IT eBooks - Free Download - Big Library</title>") do
	titleDown.slice! "<title>"
	titleDown.slice! "</title>"
	titleDown.slice! " - Free Download eBook - pdf"
	titleDown.gsub!(' ', '.')
	#Tenemos el título o nombre del archivo.
	toDownload =  /filepi\.com\/i\/.+http/.match(page.xpath("//td/a/@href").to_s).to_s
	toDownload.slice! "http"
	toDownload = gen + toDownload
	#Acá tengo el link de descarga, con referer y todo.
	listOfPaths.push "wget --referer=#{startUrl} #{toDownload} --output-document=#{titleDown}.pdf"

	i = i + 1
	page = Nokogiri::XML(open(startUrl+i.to_s))
	titleDown = page.xpath("//head/title").to_s
end

listOfPaths.each {|commandLine| exec commandLine}