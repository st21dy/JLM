class ArticleCommentsController < ApplicationController
  def create
    article = Article.find(params[:article_id])
    comment = current_user.article_comments.new(article_comment_params)
    # comment = PostComment.new(post_comment_params)
    # comment.user_id = current_user.id
    comment.article_id = article.id
    comment.save
    redirect_to article_path(article)
  end

  def destroy
    article = Article.find(params[:article_id])
    article_comment = current_user.article_comments.find_by(article_id: article.id)
    article_comment.destroy
    redirect_to article_path(article)
  end

  private

  def article_comment_params
    params.require(:article_comment).permit(:comment)
  end
end
