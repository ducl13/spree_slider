source 'http://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

spree_version = 'master'
gem 'spree', github: 'spree/spree', branch: spree_version
gem 'rails-controller-testing'

gem 'rubocop', require: false
gem 'rubocop-rspec', require: false

gemspec
