module CegonhasHelper
  def carros_na_cegonha(cegonha)
    frase = "Nenhum Carro na Cegonha."
    if cegonha.carros == 1
      frase = "1 carro: "
    else
      frase = "#{cegonha.carros} carros:"
    end 
    cegonha.cars.each do |car|
    frase = frase + link_to(car.placa, car)
    cegonha.cars.last == car ? frase = frase + '.' :frase = frase + ','
    end
    return frase
  end

  def retorna_valor_dos_fretes(cegonha)
    valor_total = 0
    cegonha.cars.each do |car|
      valor_total += car.pagamento.valor_total
    end
  return number_to_currency(valor_total, :format => "%u %n", :separator => ",", :delimiter => ".", :unit => "R$")  
  end

  
end
