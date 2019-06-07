source "https://rubygems.org"

# Specify your gem's dependencies in hightop.gemspec
gemspec

ar_version = ENV["AR_VERSION"] || "5.2.0"
gem "activerecord", "~> #{ar_version}"

unless ar_version >= "5.1"
  gem "sqlite3", "~> 1.3.0"
end
