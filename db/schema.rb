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

ActiveRecord::Schema.define(:version => 20120519061234) do

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
    t.integer  "ativo"
    t.integer  "cegonha_id"
  end

  create_table "cegonhas", :force => true do |t|
    t.string   "placa"
    t.string   "localizacao"
    t.string   "origem"
    t.string   "destino"
    t.integer  "carros"
    t.string   "comentario"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "cidade_origem"
    t.integer  "estado_origem"
    t.integer  "cidade_destino"
    t.integer  "estado_destino"
    t.integer  "cidade_id"
    t.integer  "estado_id"
  end

  create_table "cidades", :force => true do |t|
    t.string   "text"
    t.integer  "estado_id"
    t.boolean  "capital"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "compradores", :force => true do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "rg"
    t.string   "telefone"
    t.string   "celular"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "firstname"
    t.string   "middlename"
    t.string   "lastname"
    t.integer  "car_id"
    t.string   "cpf"
  end

  create_table "estados", :force => true do |t|
    t.string   "nome"
    t.string   "sigla"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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

end
