module CompradorsHelper
  def carros_do_comprador(comprador)
    frase = "Nenhum Carro comprado pelo Cliente."
    unless comprador.cars.nil?
      if comprador.cars.count > 0
        frase = "#{pluralize(comprador.cars.count, 'carro')}: "
      end
      comprador.cars.each do |car|
      frase = frase + link_to(car.placa, car)
      comprador.cars.last == car ? frase = frase + '.' :frase = frase + ', '
      end
    end
    return frase
  end
end
