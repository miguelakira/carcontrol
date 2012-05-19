require 'test_helper'

class CegonhasControllerTest < ActionController::TestCase
  setup do
    @cegonha = cegonhas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cegonhas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cegonha" do
    assert_difference('Cegonha.count') do
      post :create, cegonha: { carros: @cegonha.carros, comentario: @cegonha.comentario, destino: @cegonha.destino, localizacao: @cegonha.localizacao, origem: @cegonha.origem, placa: @cegonha.placa }
    end

    assert_redirected_to cegonha_path(assigns(:cegonha))
  end

  test "should show cegonha" do
    get :show, id: @cegonha
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cegonha
    assert_response :success
  end

  test "should update cegonha" do
    put :update, id: @cegonha, cegonha: { carros: @cegonha.carros, comentario: @cegonha.comentario, destino: @cegonha.destino, localizacao: @cegonha.localizacao, origem: @cegonha.origem, placa: @cegonha.placa }
    assert_redirected_to cegonha_path(assigns(:cegonha))
  end

  test "should destroy cegonha" do
    assert_difference('Cegonha.count', -1) do
      delete :destroy, id: @cegonha
    end

    assert_redirected_to cegonhas_path
  end
end
