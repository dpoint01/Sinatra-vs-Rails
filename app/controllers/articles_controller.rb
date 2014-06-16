class ArticlesController < ApplicationController
  def index
    @articles = Article.order('created_at DESC')
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
  end

  def new
    @categories = Category.all
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      # use redirect_to instead of redirect
      redirect_to '/articles'
    else
      flash.now[:notice] = "Uh oh! Your blog post could not be saved."
      # use render :new instead of erb :'articles/new'
      render :new
    end
  end

  private

  def article_params
    # this method will return a hash like this:
    # { title: "whatever title", author: "some person", body: "blah blah blah" }
    params.require(:article).permit(:title, :author, :body, category_ids: [])
  end

end
