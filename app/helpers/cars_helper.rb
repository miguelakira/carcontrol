module CarsHelper

  def soma_dos_pagamentos_efetuados(cliente)
    pagamento_total = 0
    if cliente.cars
      cliente.cars.each do |car|
        if car.pagamentos
          car.pagamentos.each do |pagamento|
            pagamento_total += pagamento.valor unless pagamento.nil?
          end
        end
        # codigo legado para pagamentos no sistema antigo
        pagamento_total += car.debito.valor_pago
      end
    end
    if pagamento_total.nil?
      pagamento_total = 0
    end

    return pagamento_total
  end

  def saldo_devedor_do_cliente(cliente)
    saldo_devedor = 0
    cliente.cars.each do |car|
      saldo_devedor += car.debito.valor_total

    end
    return saldo_devedor - soma_dos_pagamentos_efetuados(cliente)
  end
end
