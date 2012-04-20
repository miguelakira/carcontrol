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