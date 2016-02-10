# ruby -r "./crawler.rb" -e "Crawler.new()"
class Crawler
	require 'nokogiri'
	require 'open-uri'
	require 'open_uri_redirections'
	require 'openssl'

	def initialize
		crawl()
	end	

	def crawl
	  print "Enter URL which you want to crawl (ie. 'http://google.com') > "
      url = gets.chomp 
      get_links(url)        
	end	

	def get_links(url)
	  beginning = Time.now
      page = Crawler.open_url(url)
	  links = page.css('a')
	  hrefs = links.map {|link| link.attribute('href').to_s}.uniq.sort.delete_if {|href| href.empty?}
	  puts hrefs.size
	  threads = []
	  hrefs[0..50].each do |href|
	  	if href =~ URI::regexp  
         threads << Thread.new do
          	 begin
	            p = Crawler.open_url(href)
		  	    inputs = p.css('input')
		  	    puts "#{href}  : #{inputs.size}"
		  	 rescue => e
	  	  	     puts e.message
	  	     end  
		  end   
       end
	  end

	  threads.each do |thread|
         thread.join
       end

	  puts "Time elapsed #{Time.now - beginning} seconds"
	end

	def self.open_url(url)
		Nokogiri::HTML(open(url, :allow_redirections => :safe, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
	end	
end	 