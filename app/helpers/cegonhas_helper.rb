module CegonhasHelper
  def carros_na_cegonha(cegonha)
    frase = "Nenhum Carro na Cegonha."
    if cegonha.carros == 1
      frase = "1 carro: "
    else
      frase = "#{cegonha.carros} carros:"
    end 
    cegonha.cars.each do |car|
    frase = frase + " #{car.placa}"
    cegonha.cars.last == car ? frase = frase + '.' :frase = frase + ','
    end
    return frase
  end
end
