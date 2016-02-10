# rspec crawler_spec.rb
require 'test/unit'
require 'nokogiri'
require 'open-uri'
require 'open_uri_redirections'
require 'openssl'
require 'rspec'
require '../crawler'

class CrawlerSpec < Test::Unit::TestCase


   describe "Test crawler functions" do
 
    context "nokogiri " do
 
      it 'should open html document of the given url' do   
	      page  = Crawler.open_url('http://google.com')
	      expect(page.at_css('a')).not_to be_nil
       end

       it 'should catch input element from html page' do   
	      page  = Crawler.open_url('http://google.com')
       	  expect(page.at_css('input')).not_to be_nil
       end
 
  end

 end
 
end