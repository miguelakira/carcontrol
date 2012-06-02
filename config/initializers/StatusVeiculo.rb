#encoding=UTF-8
class StatusVeiculo
  def self.estados
    @@estados = {1 => 'Em Trânsito', 2 => 'Descarregado no Pátio',  3 => 'Aguardando Retirada', 4 => 'Com Transportadora Contratada', 0 => 'Entregue ao Cliente'}
    #@@the_array ||= # Execute the SQL query to populate the array here.
  end

  def self.add element
    if @@estados
      @@estados << element
    else
      @@estados = [element]
    end
  end
end