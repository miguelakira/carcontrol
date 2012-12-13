module ApplicationHelper

def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil

    if column == 'nome'
      if sort_direction == 'asc'
        direction = 'desc'
      end
    elsif column == 'status_pagamento'
      if sort_direction == 'asc'
        direction = 'desc'
      end
    elsif column == 'origem'
      if sort_direction == 'asc'
        direction = 'desc'
      end
    elsif column == 'destino'
      if sort_direction == 'asc'
        direction = 'desc'
      end
    elsif column == 'saldo_total'
      if sort_direction == 'asc'
        direction = 'desc'
      end
    else
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"

    end
    link_to title, :sort => column, :direction => direction
  end

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

 def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    Car.column_names.include?(params[:sort]) ? params[:sort] : "placa"
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
