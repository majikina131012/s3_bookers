class TagSearchesController < ApplicationController
  
  def search
    @model = Book
    @word = params[:content]
    # @books = Book.where("tag LIKE?", "%#{@word}%")
    @books = Book.joins(:tags).where("tags.name LIKE ?", "%#{@word}%")
    # joins(:tags)メソッドは、Bookモデルとtagsテーブルを内部結合（INNER JOIN）します。この結合により、Bookモデルとtagsテーブルが関連付けられ、tagsテーブルのデータをBookモデルから取得できるようになります
  render 'tag_searches/search'
  end
end
