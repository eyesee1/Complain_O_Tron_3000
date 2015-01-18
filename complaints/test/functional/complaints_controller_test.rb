require File.dirname(__FILE__) + '/../test_helper'

class ComplaintsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:complaints)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_complaint
    assert_difference('Complaint.count') do
      post :create, :complaint => { }
    end

    assert_redirected_to complaint_path(assigns(:complaint))
  end

  def test_should_show_complaint
    get :show, :id => complaints(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => complaints(:one).id
    assert_response :success
  end

  def test_should_update_complaint
    put :update, :id => complaints(:one).id, :complaint => { }
    assert_redirected_to complaint_path(assigns(:complaint))
  end

  def test_should_destroy_complaint
    assert_difference('Complaint.count', -1) do
      delete :destroy, :id => complaints(:one).id
    end

    assert_redirected_to complaints_path
  end
end
