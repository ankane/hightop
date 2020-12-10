source "https://rubygems.org"

# Specify your gem's dependencies in hightop.gemspec
gemspec

ar_version = ENV["AR_VERSION"] || "6.1.0"
gem "activerecord", "~> #{ar_version}"

unless ar_version >= "5.1"
  gem "sqlite3", "~> 1.3.0"
end

case ENV["ADAPTER"]
when "postgresql"
  gem "pg"
when "mysql"
  gem "mysql2"
end
