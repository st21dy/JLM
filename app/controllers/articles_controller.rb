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
    @user = User.find(@article.user_id)
    @article_comment = ArticleComment.new

  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path

  end

  def edit
    @article = Article.find(params[:id])

  end

  def update
    article = Article.find(params[:id])
    article.update(article_params)
    redirect_to articles_path

  end
  
  def search
    @articles = Article.search(params[:keyword])
    @keyword = params[:keyword]

  end


  private

  def article_params
    params.require(:article).permit(:title, :body, :video, :tag)
  end

end
