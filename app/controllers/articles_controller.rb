class ArticlesController < ApplicationController

  def new
    @article = Article.new

  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.save
    redirect_to articles_path

  end

  def index
    @articles = Article.page(params[:page]).reverse_order

  end

  def show
    @article = Article.find(params[:id])

  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path

  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :video)
  end


end
