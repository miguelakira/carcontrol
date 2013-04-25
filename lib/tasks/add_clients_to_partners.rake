desc 'Searching for clients to add to partners'
task :add_clients_to_partners => :environment do
  parceiros = Parceiro.where(:carros != nil, :carros != 0)
  parceiros.each do |parceiro|
    parceiro.cars.each do |car|
      if car.comprador
        car.comprador.update_attributes(:parceiro_id => parceiro.id) if car.comprador.parceiro_id.nil?
      elsif car.empresa
        car.empresa.update_attributes(:parceiro_id => parceiro.id) if car.empresa.parceiro_id.nil?
      end
    end
  end
end

