module CompradorsHelper
  def carros_ativos_do_cliente(cliente)
    frase = "Nenhum carro ativo."
    unless cliente.cars.nil?
      if cliente.carros_ativos > 0
        frase = "#{pluralize(cliente.carros_ativos, 'carro')}: "
      end
      cliente.cars.each do |car|
        unless car.ativo? == false
          frase = frase + link_to(car.placa, car)
          cliente.cars.last == car ? frase = frase + '.' :frase = frase + ', '
        end
      end
    end
    return frase
  end
end
