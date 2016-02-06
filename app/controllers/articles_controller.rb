class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    # @articles = Article.all
    if params[:search]
      @articles = Article.search(params[:search]).order("created_at DESC")
    elsif params[:tag]
      @articles = Article.searchByTag(params[:tag]).order("created_at DESC")
    else
      @articles = Article.order("created_at DESC")
    end
    getRecentArticle()
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    increaseHitCount()
    showInfoInHomePage()
  end

  # GET /articles/new
  def new
    @article = Article.new
    showInfoInHomePage()
  end

  # GET /articles/1/edit
  def edit
    showInfoInHomePage()
  end

  # GET /about
  def about
    showInfoInHomePage()
  end

  def increaseHitCount
    @article.hit =  @article.hit.to_i + 1 
    @article.save
  end

  def showInfoInHomePage
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    getRecentArticle()
    render 'index'
  end

  def getRecentArticle
    @recents = Article.last(5).reverse
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :feature)
    end
end
