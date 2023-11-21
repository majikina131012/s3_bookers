class BookTagsController < ApplicationController
  
  def create
    @book_tag = BookTag.new(book_tag_params)
  end  
  
end
