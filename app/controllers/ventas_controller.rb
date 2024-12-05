class VentasController < ApplicationController
  def listar
    @ventas = Venta.all
  end

  def asentar
  end

  def cancelar
  end
end
