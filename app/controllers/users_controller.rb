class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :show, :update]
	before_action :require_user, except: [:new, :index, :show, :create]
	before_action only: [:edit, :update, :destroy] do
	  require_same_user(@user)
	end
	before_action :require_admin, only: [:destroy]

	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome to the blog #{@user.username}!"
			redirect_to user_path(@user)
		else
			render :new
		end
	end

	def edit
		set_user
	end

	def update
		set_user

		if @user.update(user_params)
			flash[:warning] = "User credentials updated"
			redirect_to articles_path
		else
			render :edit
		end
	end

	def show
		set_user
		@user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
	end

	def destroy
		set_user
		@user.destroy
		flash[:danger] = "User and all articles have been deleted"
		redirect_to root_path
	end

	private
	def user_params
		params.require(:user).permit(:email, :username, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end
end
