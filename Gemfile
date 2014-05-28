source 'https://rubygems.org'

ruby "1.9.3"

gem 'rails', '3.2.18'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'exception_notification'

gem "haml-rails"

gem 'devise', '2.2.7'
gem 'heroku'

gem 'gon'
gem 'zurb-foundation'
gem 'will_paginate', '3.0.3'
gem 'thin'
gem 'pjax_rails'

gem 'squeel'
gem 'pdfkit'
gem 'wkhtmltopdf-binary'
gem 'taps'

gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'

# Gems used only for assets and not requiredg
# in production environments by default.
# como disse, só com terapia

group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'uglifier', '>= 1.0.3'
  gem 'therubyracer'
  gem 'execjs'

end

group :development, :test do
  gem 'mysql2'
  gem 'rspec-rails', '~> 2.0'
  gem 'factory_girl_rails', '~> 3.2.0'
  gem 'guard-rspec', '~> 0.7.0'
  gem 'sqlite3'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'debugger'
end

group :production do
	gem 'pg'
end

group :test do
  gem 'faker', '~> 1.0.1'
  gem 'capybara', '~> 1.1.2'
  gem 'database_cleaner', '~> 0.7.2'
  gem 'launchy', '~> 2.1.0'
end

gem 'jquery-rails'
