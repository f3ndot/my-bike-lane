require 'test_helper'

class ViolatorsControllerTest < ActionController::TestCase
  setup do
    @violator = violators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:violators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create violator" do
    assert_difference('Violator.count') do
      post :create, violator: {  }
    end

    assert_redirected_to violator_path(assigns(:violator))
  end

  test "should show violator" do
    get :show, id: @violator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @violator
    assert_response :success
  end

  test "should update violator" do
    put :update, id: @violator, violator: {  }
    assert_redirected_to violator_path(assigns(:violator))
  end

  test "should destroy violator" do
    assert_difference('Violator.count', -1) do
      delete :destroy, id: @violator
    end

    assert_redirected_to violators_path
  end
end
