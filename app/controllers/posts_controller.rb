class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy]
  before_action :require_user, except: %i[ index show ]
  before_action :require_same_user, only: %i[ edit update destroy ]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def show
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "新規投稿が完了しました"
      redirect_to @post
    else
      render "new", status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "投稿を更新しました"
      redirect_to @post
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path, status: :see_other
  end

  private

    def set_post
      @post = Post.find_by(id: params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :address)
    end

    def require_same_user
      if current_user != @post.user
        flash[:error] = "許可されていない操作です。投稿の編集、削除は投稿者ご自身のみ可能です。"
        redirect_to @post
      end
    end

    def require_host_account
      if !(current_user.account_type == "host")
        flash[:error] = "投稿はホストアカウント登録者のみ可能です。一般ユーザーは投稿できません。"
        redirect_to root_path
      end
    end
end
