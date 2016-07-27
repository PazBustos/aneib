require 'test_helper'

class OrganizationnsControllerTest < ActionController::TestCase
  setup do
    @organizationn = organizationns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:organizationns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create organizationn" do
    assert_difference('Organizationn.count') do
      post :create, organizationn: { description: @organizationn.description, title: @organizationn.title }
    end

    assert_redirected_to organizationn_path(assigns(:organizationn))
  end

  test "should show organizationn" do
    get :show, id: @organizationn
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @organizationn
    assert_response :success
  end

  test "should update organizationn" do
    patch :update, id: @organizationn, organizationn: { description: @organizationn.description, title: @organizationn.title }
    assert_redirected_to organizationn_path(assigns(:organizationn))
  end

  test "should destroy organizationn" do
    assert_difference('Organizationn.count', -1) do
      delete :destroy, id: @organizationn
    end

    assert_redirected_to organizationns_path
  end
end
