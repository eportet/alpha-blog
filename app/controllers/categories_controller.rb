class CategoriesController < ApplicationController
	before_action :require_admin, except: [:index, :show]


	def index
		@categories = Category.paginate(page: params[:page], per_page: 5)
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "Category created successfully"
			redirect_to categories_path
		else
			render :new
		end
	end

	def edit
		set_category
	end

	def update
		set_category
		if @category.update(category_params)
			flash[:succes] = "Category updated"
			redirect_to category_path(@category)
		else
			render :edit
		end
	end

	def show
		set_category
		@category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
	end

	private
	def category_params
		params.require(:category).permit(:name)
	end

	def set_category
		@category = Category.find(params[:id])
	end

end