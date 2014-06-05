module ApplicationHelper

  def pdf_image_tag(image, options = {})
    options[:src] = File.expand_path(Rails.root) + '' + image
    tag(:img, options)
  end

  def retorna_valor_dos_fretes(terceiro)
    valor_total = 0
    terceiro.cars.each do |car|
      valor_total += car.debito.valor_total
    end
    return number_to_currency(valor_total, :format => "%u %n", :separator => ",", :delimiter => ".", :unit => "R$")
  end

  def vehicle_status_as_array_with_index
    [*VEHICLE_STATUS.collect {|v,i| [t(v),VEHICLE_STATUS.index(v)] }]
  end

end
