require 'bookmark' 
require 'capybara'

describe Bookmark do 

  describe '#all' do 
   
    it 'returns all bookmarks' do 
      connection = PG.connect(dbname: 'bookmark_manager_test')
      Bookmark.add("http://www.makersacademy.com", "Makers Academy")
      Bookmark.add("http://www.google.com", "Google")
      bookmarks = Bookmark.all
      p bookmarks
      expect(bookmarks.to_s).to include "Makers Academy"
      expect(bookmarks.to_s).to include "Google"
      # expect(bookmarks).to include "bookmark 3"
    end
  end
end 