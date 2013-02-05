module CegonhasHelper
  def carros_na_cegonha(cegonha)
    frase = "Nenhum Carro na Cegonha."
    unless cegonha.carros.nil?
      if cegonha.carros > 0
        frase = "#{pluralize(cegonha.carros, 'carro')}: "
      end
      cegonha.cars.each do |car|
      frase = frase + link_to(car.placa, car)
      cegonha.cars.last == car ? frase = frase + '.' :frase = frase + ', '
      end
    end
    return frase
  end
end
