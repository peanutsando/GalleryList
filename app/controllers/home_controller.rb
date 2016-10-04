require 'nokogiri'
require 'open-uri'
require 'json'
require 'rubygems'

class HomeController < ApplicationController
  def index
    
    out = File.open('gallery.json', 'w')
    
    # Seed에 저장된 갤러리 목록 가져오기
    @gallery_list = Gallery.order(name: :asc).all
    
    @gallery_list.each do |list|
      gallery = {:galleryId => list.url, :galleryName => list.name}
      out.puts gallery.to_json
    end
  end   
end
