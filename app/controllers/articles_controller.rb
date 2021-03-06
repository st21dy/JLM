class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to articles_path
    else
      render :new
    end
  end

  def index
    @articles = Article.page(params[:page]).per(50)
  end

  def show
    @article = Article.find(params[:id])
    @user = User.find(@article.user_id)
    @article_comment = ArticleComment.new
  end

  def destroy
    @article = Article.find(params[:id])
    @article.remove_video!
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

  def hashtag
    @user = current_user
    @tag = Hashtag.find_by(hashname: params[:name])
    @articles = @tag.articles
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :video, :caption, hashtag_ids: [])
  end
end
