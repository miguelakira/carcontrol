require 'test_helper'

class CompradoresControllerTest < ActionController::TestCase
  setup do
    @comprador = compradores(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:compradores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comprador" do
    assert_difference('Comprador.count') do
      post :create, comprador: { celular: @comprador.celular, email: @comprador.email, nome: @comprador.nome, rg: @comprador.rg, telefone: @comprador.telefone }
    end

    assert_redirected_to comprador_path(assigns(:comprador))
  end

  test "should show comprador" do
    get :show, id: @comprador
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comprador
    assert_response :success
  end

  test "should update comprador" do
    put :update, id: @comprador, comprador: { celular: @comprador.celular, email: @comprador.email, nome: @comprador.nome, rg: @comprador.rg, telefone: @comprador.telefone }
    assert_redirected_to comprador_path(assigns(:comprador))
  end

  test "should destroy comprador" do
    assert_difference('Comprador.count', -1) do
      delete :destroy, id: @comprador
    end

    assert_redirected_to compradores_path
  end
end
