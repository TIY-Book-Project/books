class GoogleBooksApi
  include HTTParty
  base_uri 'https://www.googleapis.com/books/v1/'
  default_params key: ENV["GOOGLE_KEY"]

  def initialize search_term, opts={}
    @search_term = search_term
    @author = opts[:author]
  end

  def build_search_q
    q = @search_term
    if @author
      q += "+inauthor:#{@author}"
    end
    q
  end
  # /volumes?q=...
  # /volumes?q=Potter+inauthor:Rowling
  def run
    # self.class.get is equivalent. Which is better?
    # BookSearch.get '/volumes' ...
    # eqivalent to BookSearch.get _for instances of this class_
    response = self.class.get '/volumes', query: { q: build_search_q }
    response["items"]
  end

end
