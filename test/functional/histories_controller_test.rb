require 'test_helper'

class HistoriesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:histories)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_history
    assert_difference('History.count') do
      post :create, :history => { }
    end

    assert_redirected_to history_path(assigns(:history))
  end

  def test_should_show_history
    get :show, :id => histories(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => histories(:one).id
    assert_response :success
  end

  def test_should_update_history
    put :update, :id => histories(:one).id, :history => { }
    assert_redirected_to history_path(assigns(:history))
  end

  def test_should_destroy_history
    assert_difference('History.count', -1) do
      delete :destroy, :id => histories(:one).id
    end

    assert_redirected_to histories_path
  end
end
