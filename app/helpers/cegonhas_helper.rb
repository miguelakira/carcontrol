module CegonhasHelper
  def carros_na_cegonha(cegonha)
    frase = "Nenhum Carro na Cegonha."
    unless cegonha.cars.count.nil?
      if cegonha.cars.count > 0
        frase = "#{pluralize(cegonha.cars.count, 'carro')}: "
      end
      cegonha.cars.each do |car|
      frase = frase + link_to(car.placa, car)
      cegonha.cars.last == car ? frase = frase + '.' :frase = frase + ', '
      end
    end
    return frase
  end
end
