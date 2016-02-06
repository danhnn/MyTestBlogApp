class TagsController < ApplicationController
 def create
    @article = Article.find(params[:article_id])
    @comment = @article.tags.create(tag_params)
    redirect_to article_path(@article)
  end
 
 def destroy
    @article = Article.find(params[:article_id])
    @tag = @article.tags.find(params[:id])
    @tag.destroy
    redirect_to article_path(@article)
  end

  private
    def tag_params
      params.require(:tag).permit(:key)
    end
end
