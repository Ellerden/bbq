source 'https://rubygems.org'
git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.1'
gem 'twitter-bootstrap-rails'
gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'
# gem 'russian'

gem 'carrierwave'
gem 'rmagick', '>= 2.16.0'

# gem 'rails', '~> 4.2.6'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'listen', '~> 3.1.5' #пришлось его добавить, хз что он делает пока

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
end

group :production do
  gem 'pg'
end
