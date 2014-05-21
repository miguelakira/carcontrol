module CompradorsHelper
  def carros_ativos_do_cliente(cliente)
    frase = "Nenhum carro ativo."
    if !cliente.cars.nil?
      if cliente.active_cars.count > 0
        frase = "#{pluralize(cliente.active_cars.count, 'carro')}: "
      end
      cliente.active_cars.each do |car|
        frase = frase + link_to(car.placa, car)
        cliente.cars.last == car ? frase = frase + '.' :frase = frase + ', '
      end
    end
    return frase
  end
end
