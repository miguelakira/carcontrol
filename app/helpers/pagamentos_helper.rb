module PagamentosHelper
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
    return (frete_total_do_cliente(cliente) - soma_dos_pagamentos_efetuados(cliente)) * -1
  end

  def frete_total_do_cliente(cliente)
    frete_total = 0
    cliente.cars.each do |car|
      frete_total += car.debito.valor_total - car.debito.desconto
    end
    return frete_total
  end
end