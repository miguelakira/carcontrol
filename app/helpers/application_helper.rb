module ApplicationHelper
# def button(name,url)
  def button(*args)
    if args.size == 2
      name = args[0]
      url = args[1]
      content_tag :button, :type => "button", :onclick => "window.location.href =  '#{url_for(url)}'; " do
        "#{name}"
      end
    elsif args.size == 1
      name = args[0]
      content_tag :button, :type => "button" do
        "#{name}"
      end
    end
  end

  def retorna_valor_monetario(valor)
    number_to_currency(valor, :format => "%u %n", :separator => ",", :delimiter => ".", :unit => "R$")
  end

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


end
