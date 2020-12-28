source "https://rubygems.org"

gemspec

gem "rake"
gem "minitest", ">= 5"

ar_version = ENV["AR_VERSION"] || "6.1.0"
gem "activerecord", "~> #{ar_version}"

case ENV["ADAPTER"]
when "postgresql"
  gem "pg"
when "mysql"
  gem "mysql2"
else
  gem "sqlite3", (ar_version >= "5.1" ? nil : "~> 1.3.0")
end
