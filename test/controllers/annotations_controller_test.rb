require 'test_helper'

class AnnotationsControllerTest < ActionController::TestCase
  setup do
    @annotation = annotations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:annotations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create annotation" do
    assert_difference('Annotation.count') do
      post :create, annotation: { appropriate: @annotation.appropriate, finished: @annotation.finished, image_files: @annotation.image_files, label: @annotation.label, not_appropriate: @annotation.not_appropriate, prefer_user: @annotation.prefer_user, priority: @annotation.priority, skipped: @annotation.skipped, text_file: @annotation.text_file, user_id: @annotation.user_id }
    end

    assert_redirected_to annotation_path(assigns(:annotation))
  end

  test "should show annotation" do
    get :show, id: @annotation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @annotation
    assert_response :success
  end

  test "should update annotation" do
    patch :update, id: @annotation, annotation: { appropriate: @annotation.appropriate, finished: @annotation.finished, image_files: @annotation.image_files, label: @annotation.label, not_appropriate: @annotation.not_appropriate, prefer_user: @annotation.prefer_user, priority: @annotation.priority, skipped: @annotation.skipped, text_file: @annotation.text_file, user_id: @annotation.user_id }
    assert_redirected_to annotation_path(assigns(:annotation))
  end

  test "should destroy annotation" do
    assert_difference('Annotation.count', -1) do
      delete :destroy, id: @annotation
    end

    assert_redirected_to annotations_path
  end
end
