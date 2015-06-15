class ArticlesController < ApplicationController

  before_action :find_article, only: [:show, :create_comment, :destroy]
  before_action :set_cache_control_headers, only: [:index, :show]
  before_action :set_private, only: [:create_comment, :create_article]

  # Returns all Article objects, and sets a table_key of 'articles',
  # and a record_key for each article object: "#{table_key}/#{article_id}"
  def index
    @articles = Article.all
    set_surrogate_key_header 'articles', @articles.map(&:record_key)
  end

  # Sets a surrogate key for the current article.
  #
  # Example:
  #
  #   Article[75]
  #   Surrogate-Key:articles/75
  def show
    set_surrogate_key_header @article.record_key
  end

  # Creates a new comment for current article
  def create_comment
    @article.create_random_comment
    redirect_to article_path(@article)
  end

  # Creates a new article
  def create_article
    new_article = Article.create_random_article
    redirect_to articles_url
  end

  # Deletes the current article.
  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def find_article
    @article = Article.find(params[:id])
    redirect_to articles_path unless @article
  end

  # Private: Sets Cache-Control headers to not store content
  # Used for create methods.
  def set_private
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
  end
end
