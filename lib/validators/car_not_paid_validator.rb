#encoding: UTF-8
class CarNotPaidValidator < ActiveModel::EachValidator  
  def validate_each(record, attribute, value)  
    
    if value != 3 and VEHICLE_STATUS[record.ativo] == 'DELIVERED'
      record.ativo = Car.find(record.id).ativo  
      record.errors[attribute] << ": O carro não pode ser declarado como Entregue ao Cliente pois ainda não foi pago."  
      
    end
  end  
end  


