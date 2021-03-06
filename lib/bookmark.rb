require 'pg'

class Bookmark
#self is a new instance of a class
attr_reader :id, :title, :url
  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end
  
  def connect
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
  end

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec( "SELECT * FROM bookmarks" )
    result.map do |bookmark|
     Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url']) 
    end
  end

  def self.add(new_url, new_title = nil)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec( "INSERT INTO bookmarks (url, title) VALUES('#{new_url}', '#{new_title}')" )
  end
end