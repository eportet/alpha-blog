require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

	def setup
		@category = Category.create(name: "sports")
		@user = User.create(username: "test", email: "test@test.com", password: "test", admin: true)
	end

	test "should get categories index" do
		get categories_path
		assert_response :success
	end

	test "should get new" do
		sign_in_as(@user, "test")
		get new_category_path
		assert_response :success
	end

	test "should get show" do
		get category_path(@category)
		assert_response :success
	end

	test "should redirect create when admin not logged in" do
		assert_no_difference 'Category.count' do
			post categories_path, params: { category: { name: "sports" } }
		end
		assert_redirected_to root_path
	end

end
