require "test_helper"

class VentasControllerTest < ActionDispatch::IntegrationTest
  test "should get listar" do
    get ventas_listar_url
    assert_response :success
  end

  test "should get asentar" do
    get ventas_asentar_url
    assert_response :success
  end

  test "should get cancelar" do
    get ventas_cancelar_url
    assert_response :success
  end
end
