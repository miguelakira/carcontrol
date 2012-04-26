#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if StatusPagamento.all.empty?
	statuspagamentos = StatusPagamento.create([{ status: "Não Pago", value: 1}, {status: 'Pendente', value: 2}, {status:'Pago', value: 3}])
end

if Estado.all.empty?
	estados = Estado.create([{ nome: "Acre", sigla: 'AC'}, {nome: 'Alagoas', sigla: 'AL'}, {nome:'Amapá', sigla: 'AP'}, 
			{nome:'Amazonas', sigla: 'AM'}, {nome:'Bahia', sigla: 'BA'}, {nome:'Ceará', sigla: 'CE'}, {nome:'Distrito Federal', sigla: 'DF'}, 
			{nome:'Espírito Santo', sigla: 'ES'}, {nome:'Goiás', sigla: 'GO'}, {nome:'Maranhão', sigla: 'MA'}, {nome:'Mato Grosso', sigla: 'MT'}, 
			{nome:'Mato Grosso do Sul', sigla: 'MS'}, {nome:'Minas Gerais', sigla: 'MG'}, {nome:'Pará', sigla: 'PA'}, {nome:'Paraíba', sigla: 'PB'}, 
			{nome:'Paraná', sigla: 'PR'}, {nome:'Pernambuco', sigla: 'PE'}, {nome:'Piauí', sigla: 'PI'}, {nome:'Rio de Janeiro', sigla: 'RJ'}, 
			{nome:'Rio Grande do Norte', sigla: 'RN'}, {nome:'Rio Grande do Sul', sigla: 'RS'}, {nome:'Rondônia', sigla: 'RO'}, {nome:'Roraima', sigla: 'RR'}, 
			{nome:'Santa Catarina', sigla: 'SC'}, {nome:'São Paulo', sigla: 'SP'}, {nome:'Sergipe', sigla: 'SE'}, {nome:'Tocantins', sigla: 'TO'}
		])
end


	

	


	
