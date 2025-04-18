source "https://rubygems.org"

gemspec

gem "rake"
gem "minitest", ">= 5"

ar_version = ENV["AR_VERSION"] || "8.0.0"
gem "activerecord", "~> #{ar_version}"

case ENV["ADAPTER"]
when "postgresql"
  gem "pg"
when "mysql"
  gem "mysql2"
else
  gem "sqlite3"
end
