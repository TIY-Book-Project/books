class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :reviews]

  # before_filter :set_json_format, except: [:index, :show]

  return_json except: [:index, :show, :recommend, :search]

  # def search
  #   # @results = BookSearch.new(params[:search]).run
  #   # render :json => @results
  #
  #   redirect_to :index
  # end

  def reviews
    @reviews = Book.find(params[:id]).reviews
  end

  def recommendations
    @recommendations = current_user.received_recommendations
  end

  def index
    @books = Book.all
    if params[:search]
      @results = GoogleBooksApi.new(params[:search]).run
      # redirect_to root_path
      # render :json => @result
    end
    respond_to do |format|
      format.json { render file: "books/index.json.jbuilder" }
      format.html { render :index }
    end
  end

  def show
    @book = Book.find params[:id]
  end

  def create
    @book = Book.new create_params.merge(creator: current_user)
    if @book.save
      render :show
    else
      render_invalid @book
    end
  end

  def update
    @book = Book.find params[:id]
    authorize! :edit, @book
    if @book.update update_params
      render :show
    else
      render_invalid @book
    end
  end

  def review
    book = Book.find params[:id]
    @review = book.reviews.new(
      review_params.merge( user: current_user ))
    if @review.save
      render :review
    else
      render_invalid @review
    end
  end

  def recommend
    book = Book.find params[:id]
    @recommendation = book.recommendations.create!(
      recommendation_params.merge( sender: current_user ))
    RecommendationMailer.send_recommendation(@recommendation).deliver
  end

private

  def create_params
    params.require(:book).
      permit(:title, :author, :isbn, :image_url, :description).
      merge(created_by: current_user)
  end

  def update_params
    params.require(:book).permit(:title, :author, :isbn, :image_url, :description)
  end

  # N.B. This smells like it should be in a ReviewsController
  def review_params
    params.require(:review).permit(:rating, :text)
  end
  def recommendation_params
    params.require(:recommendation).permit(:text, :recipient_id)
  end
end
