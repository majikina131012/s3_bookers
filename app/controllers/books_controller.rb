class BooksController < ApplicationController
  def index
    @book = Book.new
    @users = User.all
    @user = current_user
    @tag_list = Tag.all
    if params[:latest]
      @books = Book.latest
    elsif params[:old]
      @books = Book.old
    elsif params[:star_count]
      @books = Book.star_count
    else
      @books = Book.all
    end
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    tag_list = params[:book][:name].split(',')
    if @book.save
      @book.save_tag(tag_list)
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      @user = current_user
      render :index
    end  
  end
  
  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @post_comment = PostComment.new
    @book_comment = BookComment.new
    @book_tags = @book.tags
  end
  
  def edit
    @book = Book.find(params[:id])
    @tag_list = @book.tags.pluck(:name).join(',')
    unless @book.user == current_user
      redirect_to books_path
    end  
  end
  
   def update
    @book = Book.find(params[:id])
    tag_list = params[:book][:name].split(',')
    if @book.update(book_params)
      @book.save_tag(tag_list)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end  
   end
  
  def destroy
     @book = Book.find(params[:id])
     @book.destroy
     redirect_to books_path
  end
  
  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @books = @tag.books
  end  
  
  private

  def book_params
    params.require(:book).permit(:title, :body, :star)
  end
  
end