class PostsController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :search]

  def index
    @posts = Post.all.order(:updated_at => :desc).page(params[:page])
  end

  def search
    @title = "검색 결과"

    types = []
    if params[:search][:sell] == "1"
      types.push 1
    end
    if params[:search][:buy] == "1"
      types.push 2
    end
    if params[:search][:lend] == "1"
      types.push 3
    end
    if params[:search][:borrow] == "1"
      types.push 4
    end
    if types.empty?
      types = [1, 2, 3, 4]
    end

    @posts = Post.where(:trade_type => types)
                 .where("#{params[:search][:search_type]} LIKE ?",
                        "%#{params[:search][:search_text]}%")
                 .order(:updated_at => :desc)
                 .page(params[:page])
  end

  def create
    @post = current_user.posts.new(post_params)
    if !@post || !@post.save
      render("new")
      return
    end

    redirect_to posts_user_path(current_user)
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to posts_user_path(current_user)
    else
      render("edit")
    end
  end

  def destroy
    Post.find(params[:id]).destroy

    redirect_to :back
  end

  private

  def post_params
    params.require(:post).permit(:trade_type, :title, :author, :course,
                                 :edition, :price, :book_condition, :contact,
                                 :picture)
  end
end
