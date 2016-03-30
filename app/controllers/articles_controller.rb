class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy ,:views]
  before_action :authenticate_user!, except:[:index,:show,:profile,:find ,:views]
  before_action :views, only: [:show]
   before_action :signed_in_user,only:[:edit,:update,:destroy]


  # GET /articles
  # GET /articles.json
  def index
    if params[:search]
      # @articles = Article.search(params[:search]).order("created_at DESC")

    else
      @articles = Article.order("created_at DESC")
      @users=User.all
      @articlev=Article.order("view_count DESC")
    end
    
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @am = []
    @articles=Article.order("view_count DESC")
    @article.tags.each do |abc|
      @am = @am + abc.articles
       end
       @am=@am.uniq
  
      
    
    @comment=Comment.new
    @comment.article_id=@article.id
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
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
  def profile
   @user=User.find(params[:id]) 
  end
  def signed_in_user
   
    if current_user.id != @article.user_id
       flash[:notice] = "You don't have access to that article!" 
       redirect_to articles_path
    end
   end
  def find

    @articless= Article.search(params[:search]).order("created_at DESC")
    respond_to do |format|
      format.js
     

    end
  end
  def views
    a=@article.view_count
    a=a+1
    @article.view_count=a
    @article.save
  end
  def tags
    @tag=Tag.find(params[:id])
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.fetch(:article, {}).permit(:title,:body,:tag_list,:photo)
    end
end
