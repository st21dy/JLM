class ArticlesController < ApplicationController

  def new
    @article = Article.new

  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.save
    redirect_to articles_path
    tag_list = params[:article][:tag_name].split(",")
    if @article.save
      @article.save_tag(tag_list)
    end

  end

  def index
    @articles = Article.page(params[:page]).reverse_order
    @tag_list = Tag.all
    #ビューでタグ一覧を表示するために全取得。

  end

  def show
    @article = Article.find(params[:id])
    @article_tags = @article.tags
    #そのクリックした投稿に紐付けられているタグの取得。
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
    @tag_list = Tag.all
    #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])
    #クリックしたタグを取得
    @articles = @tag.articles.all
    #クリックしたタグに紐付けられた投稿を全て表示

  end


  private

  def article_params
    params.require(:article).permit(:title, :body, :video)
  end


end
