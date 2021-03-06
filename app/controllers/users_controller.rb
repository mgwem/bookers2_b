class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @book_today = @books.created_today
    @book_yesterday = @books.created_yesterday
    @book_this_week = @books.created_this_week
    @book_last_week = @books.created_last_week

    @book_2days_ago = @books.created_2day_ago
    @book_3days_ago = @books.created_3day_ago
    @book_4days_ago = @books.created_4day_ago
    @book_5days_ago = @books.created_5day_ago
    @book_6days_ago = @books.created_6day_ago

  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def daily_posts
    user = User.find(params[:user_id])
    @books = user.books.where(created_at: params[:created_at].to_date.all_day)
    render :daily_posts_form
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
