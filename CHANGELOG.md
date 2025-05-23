## 0.6.0 (2025-05-04)

- Dropped support for Active Record < 7.1 and Ruby < 3.2
- Dropped support for Mongoid < 8

## 0.5.0 (2024-10-07)

- Fixed connection leasing for Active Record 7.2+
- Dropped support for Active Record < 7 and Ruby < 3.1

## 0.4.0 (2023-07-02)

- Dropped support for Active Record < 6.1 and Ruby < 3
- Dropped support for Mongoid < 7

## 0.3.0 (2021-08-12)

- Raise `ActiveRecord::UnknownAttributeReference` for non-attribute arguments
- Raise `ArgumentError` for too many arguments with arrays and hashes
- Removed `uniq` option (use `distinct` instead)
- Dropped support for Active Record < 5.2 and Ruby < 2.6

## 0.2.4 (2020-09-07)

- Added warning for non-attribute argument
- Added deprecation warning for `uniq`

## 0.2.3 (2020-06-18)

- Dropped support for Active Record 4.2 and Ruby 2.3
- Fixed deprecation warning in Ruby 2.7

## 0.2.2 (2019-08-12)

- Added support for Mongoid

## 0.2.1 (2019-08-04)

- Added support for arrays and hashes

## 0.2.0 (2017-03-19)

- Use keyword arguments

## 0.1.4 (2016-02-04)

- Added `distinct` option to replace `uniq`

## 0.1.3 (2015-06-18)

- Fixed `min` option with `uniq`

## 0.1.2 (2014-11-05)

- Added `min` option

## 0.1.1 (2014-07-02)

- Added `uniq` option
- Fixed `Model.limit(n).top`

## 0.1.0 (2014-06-11)

- No changes, just bump

## 0.0.4 (2014-06-11)

- Added support for multiple groups
- Added `nil` option

## 0.0.3 (2014-06-11)

- Fixed escaping

## 0.0.2 (2014-05-29)

- Added `limit` parameter

## 0.0.1 (2014-05-11)

- First release
