require 'test_helper'

class API::InstatsControllerTest < ActionController::TestCase
  setup do
    @api_instat = api_instats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_instats)
  end

  test "should create api_instat" do
    assert_difference('API::Instat.count') do
      post :create, api_instat: {  }
    end

    assert_response 201
  end

  test "should show api_instat" do
    get :show, id: @api_instat
    assert_response :success
  end

  test "should update api_instat" do
    put :update, id: @api_instat, api_instat: {  }
    assert_response 204
  end

  test "should destroy api_instat" do
    assert_difference('API::Instat.count', -1) do
      delete :destroy, id: @api_instat
    end

    assert_response 204
  end
end
