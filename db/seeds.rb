# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'nokogiri'
require 'open-uri'

# html class 이름에 따라서 crawling
classList = %w(section_fashion
                  section_issue
                  section_travel_scene
                  section_food
                  section_dc_pain4
                  section_composition
                  section_dc_pain1
                  section_dc_pain2
                  section_dc_pain3
                  section_dc_pain5
                  section_dc_pain6
                  section_shopping
                  section_person1
                  section_game1
                  section_game2
                  section_game3
                  section_broadcasting1
                  section_broadcasting2
                  section_music
                  section_sports
                  section_person_entertainment1
                  section_person_entertainment2
                  section_person_sports
                  section_person_entertainment4
                  section_person_entertainment5
                  section_university
                  section_university2
                  section_person_others
                  section_success_etc
                  section_other2
                  section_area2
                  )
                  
    html = open('http://wstatic.dcinside.com/gallery/gallindex_iframe_new_gallery.html')

    doc = Nokogiri::HTML(html)
    doc.encoding = 'utf-8'

    index = 0
    # 메인 갤러리 크롤링
    while index < classList.size do
  
      titleList = doc.css('div.' + classList[index]).search('a')
      titleSize = titleList.size
      
      i = 0
      while i < titleSize do
        source = titleList.css('a[href]')[i]
        galleryLink = source.attr('href')
        # 메인 갤러리 크롤링
        galleryName = source.text.strip
        if galleryName != ''
            Gallery.create(name: galleryName, url: galleryLink)
        end
        i+=1
      end
      index+=1
    end
    
    subList = doc.css('div.cont_list').search('li')
    subSize = (subList).size
    
    i = 0
    # 서브 갤러리 크롤링
    while i < subSize do
      source = subList.css('a[href]')[i]
      galleryLink = source.attr('href')
      galleryName = source.text.strip
      if galleryName != ''
          Gallery.create(name: galleryName, url: galleryLink)
      end
      i+=1
    end