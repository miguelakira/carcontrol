module CarsHelper

  def soma_dos_pagamentos_efetuados(cliente)
    pagamento_total = 0
    if cliente.pagamentos
      cliente.pagamentos.each do |pagamento|
        unless pagamento.nil?
          pagamento.valor ||= 0
          pagamento_total += pagamento.valor
        end
      end
    end
    # codigo legado para pagamentos no sistema antigo
    cliente.cars.each do |car|
      pagamento_total += car.debito.valor_pago unless car.debito.valor_pago.nil?
    end
    if pagamento_total.nil?
      pagamento_total = 0
    end
    return pagamento_total
  end

  def saldo_devedor_do_cliente(cliente)
    saldo_devedor = 0
    cliente.cars.each do |car|
      saldo_devedor += car.debito.valor_total - car.debito.desconto
    end
    return saldo_devedor - soma_dos_pagamentos_efetuados(cliente)
  end
end
