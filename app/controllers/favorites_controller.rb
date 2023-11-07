class FavoritesController < ApplicationController
  
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    redirect_to request.referer
  end
  
  # def create
  # 	book = Book.find(params[:book_id])
  # 	favorite = Favorite.new
  # 	favorite.user_id = current_user.id
  # 	favorite.book_id = book.id
  # 	favorite.save
  # 	redirect_to request.referer
  # end 
  # 上の記述と同じ！

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    redirect_to request.referer
  end
end
