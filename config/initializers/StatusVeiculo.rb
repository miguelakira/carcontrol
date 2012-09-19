#encoding=UTF-8
class StatusVeiculo
  def self.estados
    @@estados = {5 => 'Aguardando Carregamento', 1 => 'Em Trânsito', 2 => 'Descarregado no Pátio', 4 => 'Com Transportadora Contratada', 3 => 'Aguardando Retirada pelo Cliente', 6 => 'Em Logística', 0 => 'Entregue ao Cliente'}
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