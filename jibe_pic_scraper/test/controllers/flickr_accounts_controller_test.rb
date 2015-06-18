require 'test_helper'

class FlickrAccountsControllerTest < ActionController::TestCase
  setup do
    @flickr_account = flickr_accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flickr_accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flickr_account" do
    assert_difference('FlickrAccount.count') do
      post :create, flickr_account: { access_token: @flickr_account.access_token, username: @flickr_account.username }
    end

    assert_redirected_to flickr_account_path(assigns(:flickr_account))
  end

  test "should show flickr_account" do
    get :show, id: @flickr_account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flickr_account
    assert_response :success
  end

  test "should update flickr_account" do
    patch :update, id: @flickr_account, flickr_account: { access_token: @flickr_account.access_token, username: @flickr_account.username }
    assert_redirected_to flickr_account_path(assigns(:flickr_account))
  end

  test "should destroy flickr_account" do
    assert_difference('FlickrAccount.count', -1) do
      delete :destroy, id: @flickr_account
    end

    assert_redirected_to flickr_accounts_path
  end
end
