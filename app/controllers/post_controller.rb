class PostController < ApplicationController
  include PostHelper
  helper_method :sort_column, :sort_direction
  before_action :logged_in_user, only: [:create, :destroy]
  PER = 8

  def index
    if params[:current_state]
      @posts = Post.all.order(sort_column + ' ' + sort_direction).state(params[:current_state]).page(params[:page]).per(PER)
    elsif params[:search]
      @posts = Post.all.order(sort_column + ' ' + sort_direction).search(params[:search]).page(params[:page]).per(PER)
    else
      @posts = Post.all.order(sort_column + ' ' + sort_direction).page(params[:page]).per(PER)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(name: params[:name],
                     content: params[:content],
                     user_id: current_user.id,
                     current_state: 1
                    )
     deadline_check
     priority
    if @post.save
      redirect_to("/", notice: "タスクを登録しました") #引数に文字列を渡してもflash配列にメッセージを格納できる
    else
      redirect_to("/", notice: "タスクが正常に登録できませんでした")
    end
  end

  def next
    @post = Post.find_by(id: params[:id])
    if @post.current_state < 3
      @post.current_state += 1
      if @post.save
        redirect_to("/")
      else
        redirect_to("/", notice: "失敗しました")
      end
    else
      redirect_to("/", notice: "失敗しました")
    end
  end

  def back
    @post = Post.find_by(id: params[:id])
    if @post.current_state > 0
      @post.current_state -= 1
      if @post.save
        redirect_to("/")
      else
        redirect_to("/", notice: "失敗しました")
      end
    else
      redirect_to("/", notice: "失敗しました")
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.name = params[:name]
    @post.content = params[:content]
    if @post.save
      redirect_to("/", notice: "タスクを編集しました")
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/", notice: "タスクを削除しました")
  end

  private

  def sort_direction
    %w(asc desc).include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    Post.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
end
