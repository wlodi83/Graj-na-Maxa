require 'test_helper'

class AgeBracketsControllerTest < ActionController::TestCase
  setup do
    @age_bracket = age_brackets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:age_brackets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create age_bracket" do
    assert_difference('AgeBracket.count') do
      post :create, :age_bracket => @age_bracket.attributes
    end

    assert_redirected_to age_bracket_path(assigns(:age_bracket))
  end

  test "should show age_bracket" do
    get :show, :id => @age_bracket.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @age_bracket.to_param
    assert_response :success
  end

  test "should update age_bracket" do
    put :update, :id => @age_bracket.to_param, :age_bracket => @age_bracket.attributes
    assert_redirected_to age_bracket_path(assigns(:age_bracket))
  end

  test "should destroy age_bracket" do
    assert_difference('AgeBracket.count', -1) do
      delete :destroy, :id => @age_bracket.to_param
    end

    assert_redirected_to age_brackets_path
  end
end
