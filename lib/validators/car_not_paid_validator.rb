#encoding: UTF-8
class CarNotPaidValidator < ActiveModel::EachValidator  
  def validate_each(record, attribute, value)  
    
    if value != 3 and record.ativo == 0
      record.ativo = Car.find(record.id).ativo  
      record.errors[attribute] << ": O carro não pode ser declarado como Entregue ao Cliente pois ainda não foi pago."  
      
    end
  end  
end  


