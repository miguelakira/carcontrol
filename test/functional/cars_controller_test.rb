require 'test_helper'

class CarsControllerTest < ActionController::TestCase
  setup do
    @car = cars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create car" do
    assert_difference('Car.count') do
      post :create, car: { dono_id: @car.dono_id, localizacao: @car.localizacao, modelo: @car.modelo, placa: @car.placa, rota_id: @car.rota_id, status_pagamento: @car.status_pagamento }
    end

    assert_redirected_to car_path(assigns(:car))
  end

  test "should show car" do
    get :show, id: @car
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @car
    assert_response :success
  end

  test "should update car" do
    put :update, id: @car, car: { dono_id: @car.dono_id, localizacao: @car.localizacao, modelo: @car.modelo, placa: @car.placa, rota_id: @car.rota_id, status_pagamento: @car.status_pagamento }
    assert_redirected_to car_path(assigns(:car))
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete :destroy, id: @car
    end

    assert_redirected_to cars_path
  end
end
