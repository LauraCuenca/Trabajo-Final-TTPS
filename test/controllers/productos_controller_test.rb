require "test_helper"

class ProductosControllerTest < ActionDispatch::IntegrationTest
  test "should get listar" do
    get productos_listar_url
    assert_response :success
  end

  test "should get agregar" do
    get productos_agregar_url
    assert_response :success
  end

  test "should get modificar" do
    get productos_modificar_url
    assert_response :success
  end

  test "should get eliminar" do
    get productos_eliminar_url
    assert_response :success
  end

  test "should get cambiar_stock" do
    get productos_cambiar_stock_url
    assert_response :success
  end
end
