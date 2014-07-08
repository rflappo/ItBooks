require 'rubygems' # Ruby -v < 2.0.0
require 'nokogiri' # gem install nokogiri
require 'open-uri'

gen = "http://"
startUrl = "http://blogs.msdn.com/b/mssmallbiz/archive/2014/07/07/largest-collection-of-free-microsoft-ebooks-ever-including-windows-8-1-windows-8-windows-7-office-2013-office-365-office-2010-sharepoint-2013-dynamics-crm-powershell-exchange-server-lync-2013-system-center-azure-cloud-sql.aspx"


listOfPaths = Array.new
page = Nokogiri::XML(open(startUrl)).to_s
toDownload =  page.scan(/me\/[[:alnum:]]+">/)
toDownload.each {|e| e.slice! '">'}
toDownload.each {|e| listOfPaths.push "wget --referer=#{startUrl} http://ligman.#{e}"}
# --output-document=#{titleDown}.pdf
listOfPaths.each {|el| %x(#{el})} #Ejecuta, uno a uno, los wgets se ejecuten.
