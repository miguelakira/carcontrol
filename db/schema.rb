# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140701170132) do

  create_table "cars", :force => true do |t|
    t.string   "placa"
    t.string   "modelo"
    t.integer  "status_pagamento_id"
    t.integer  "rota_id"
    t.string   "localizacao"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.datetime "data_compra"
    t.integer  "estado_id"
    t.integer  "cidade_id"
    t.integer  "cidade_origem"
    t.integer  "cidade_destino"
    t.integer  "estado_origem"
    t.integer  "estado_destino"
    t.integer  "cegonha_id"
    t.integer  "ativo"
    t.integer  "comprador_id"
    t.integer  "empresa_id"
    t.string   "observacao"
    t.datetime "data_prevista"
    t.string   "nome"
    t.integer  "parceiro_id"
  end

  create_table "cegonhas", :force => true do |t|
    t.string   "placa"
    t.string   "localizacao"
    t.string   "origem"
    t.string   "destino"
    t.integer  "carros"
    t.string   "comentario"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "cidade_origem"
    t.integer  "estado_origem"
    t.integer  "cidade_destino"
    t.integer  "estado_destino"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.string   "observacao"
    t.integer  "empresa_id"
    t.string   "nome"
    t.integer  "motorista_id"
    t.integer  "rotas",          :default => 1
  end

  create_table "cidades", :force => true do |t|
    t.boolean  "capital"
    t.string   "text"
    t.integer  "estado_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "compradores", :force => true do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "rg"
    t.string   "telefone"
    t.string   "celular"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.string   "cpf"
    t.string   "observacao"
    t.string   "parente"
    t.string   "telefone_parente"
    t.integer  "parceiro_id"
  end

  create_table "contatos", :force => true do |t|
    t.string   "especie"
    t.string   "nome"
    t.string   "telefone"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.integer  "comprador_id"
    t.string   "email"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "debitos", :force => true do |t|
    t.integer  "car_id"
    t.datetime "data_pagamento"
    t.string   "forma_pagamento"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
    t.decimal  "valor_total",             :precision => 10, :scale => 0
    t.decimal  "valor_pago",              :precision => 8,  :scale => 2
    t.string   "observacao"
    t.decimal  "taxa_despacho",           :precision => 10, :scale => 0
    t.decimal  "taxa_plataforma",         :precision => 10, :scale => 0
    t.decimal  "desconto",                :precision => 10, :scale => 0
    t.decimal  "saldo_devedor",           :precision => 8,  :scale => 2, :default => 0.0
    t.integer  "cegonha_id"
    t.decimal  "valor_frete",             :precision => 10, :scale => 0
    t.decimal  "taxa_plataforma_origem",  :precision => 10, :scale => 0
    t.decimal  "taxa_plataforma_destino", :precision => 10, :scale => 0
    t.decimal  "taxa_balsa",              :precision => 10, :scale => 0
    t.integer  "comprador_id"
    t.integer  "empresa_id"
  end

  create_table "empresas", :force => true do |t|
    t.string   "nome"
    t.string   "cnpj"
    t.string   "email"
    t.string   "telefone"
    t.string   "celular"
    t.string   "contato"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "observacao"
    t.integer  "parceiro_id"
  end

  create_table "estados", :force => true do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "historicos", :force => true do |t|
    t.integer  "cegonha_id"
    t.datetime "data_entrada"
    t.datetime "data_saida"
    t.boolean  "ativo"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "car_id"
    t.string   "localizacao_entrada"
    t.string   "localizacao_saida"
    t.integer  "parceiro_id"
    t.integer  "rota"
    t.string   "nome_rota"
  end

  create_table "motorista", :force => true do |t|
    t.string   "nome"
    t.string   "telefone"
    t.string   "celular"
    t.string   "rg"
    t.string   "cpf"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "observacao"
  end

  create_table "pagamentos", :force => true do |t|
    t.integer  "comprador_id"
    t.integer  "empresa_id"
    t.datetime "data_pagamento"
    t.string   "forma_pagamento"
    t.string   "observacao"
    t.decimal  "valor",           :precision => 8, :scale => 2
    t.integer  "car_id"
    t.integer  "parceiro_id"
    t.decimal  "saldo",           :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parceiros", :force => true do |t|
    t.integer  "carros"
    t.string   "contato"
    t.string   "nome"
    t.string   "telefone"
    t.string   "celular"
    t.string   "localizacao"
    t.integer  "cidade_origem"
    t.integer  "cidade_destino"
    t.integer  "estado_origem"
    t.integer  "estado_destino"
    t.integer  "cidade_id"
    t.integer  "estado_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "cnpj"
    t.string   "email"
    t.string   "observacao"
    t.string   "cpf"
  end

  create_table "status_pagamentos", :force => true do |t|
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "value"
  end

  create_table "users", :force => true do |t|
    t.string   "rg"
    t.string   "email"
    t.integer  "base_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.boolean  "admin",                  :default => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",      :null => false
    t.integer  "item_id",        :null => false
    t.string   "event",          :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
