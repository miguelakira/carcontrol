module CarsHelper

	def retorna_valor_monetario(valor)
		number_to_currency(valor, :format => "%u %n", :separator => ",", :delimiter => ".", :unit => "R$")
	end

	def retorna_total_do_frete(car)
		number_to_currency(car.pagamento.valor_total + car.pagamento.taxa_despacho + car.pagamento.taxa_plataforma - car.pagamento.desconto, :format => "%u %n", :separator => ",", :delimiter => ".", :unit => "R$")
	end

	def retorna_saldo_devedor(car)
		number_to_currency(@car.pagamento.valor_total + @car.pagamento.taxa_despacho + @car.pagamento.taxa_plataforma - @car.pagamento.valor_pago, :format => "%u %n", :separator => ",", :delimiter => ".", :unit => "R$")
	end


end
