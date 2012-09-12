module ParceirosHelper
 def carros_com_parceiro(parceiro)
    frase = "Nenhum Carro com Parceiro."
    unless parceiro.carros.nil?
      if parceiro.carros > 0
        frase = "#{pluralize(parceiro.carros, 'carro')}: "
      end 
      parceiro.cars.each do |car|
      frase = frase + link_to(car.placa, car)
      parceiro.cars.last == car ? frase = frase + '.' :frase = frase + ', '
      end
    end
    return frase
  end

end
