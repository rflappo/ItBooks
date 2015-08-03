require 'nokogiri'
require 'open-uri'


File.open("/home/ramiro/Downloads/itbooks.list").each do |line|
	page = Nokogiri::XML(open(line.chop))
	titleDown = page.xpath("//head/title").to_s
	#Obtengamos el título o nombre del archivo.
	titleDown.slice! "<title>"
	titleDown.slice! "</title>"
	titleDown.slice! " - Free Download eBook - pdf"
	titleDown.gsub!(' ', '_')
	titleDown.downcase!
	
	toDownload =  /filepi\.com\/i\/.+http/.match(page.xpath("//td/a/@href").to_s).to_s
	toDownload.slice! "http"
	toDownload = "http://" + toDownload
	#Acá tengo el link de descarga, con referer y todo.
	system "wget --referer=http://it-ebooks.info/book/ #{toDownload} --output-document=#{titleDown}.pdf"
end
