## Unreleased

nothing

## 3.3.0 (2025-07-18)
- add: [Support revision API](https://github.com/esaio/esa-ruby/pull/72)

## 3.2.0 (2025-07-08)
- add: [Support `faraday_middlewares` option in Esa::Client](https://github.com/esaio/esa-ruby/pull/71)

## 3.1.0 (2025-02-21)
- add: [Add signed_urls method](https://github.com/esaio/esa-ruby/pull/70)

## 3.0.0 (2025-02-20)
- :warning: breaking: [Drop Support for Ruby < 3.1](https://github.com/esaio/esa-ruby/pull/67)
- ci: [Tweak CI ruby versions](https://github.com/esaio/esa-ruby/pull/65)


## 2.2.0 (2024-05-30)
- fix: [Request to add base64 gem dependency to esa gem](https://github.com/esaio/esa-ruby/pull/64)
- ci: [Tweak CI ruby versions](https://github.com/esaio/esa-ruby/pull/65)


## 2.1.0 (2023-10-03)

- add: [Support GET /v1/%{team_name}/members/%{identifier} API by ppworks · Pull Request #63 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/63)
- doc: [Update "DELETE /v1/teams/bar/members/" section in the README](https://github.com/esaio/esa-ruby/pull/62)
- ci: [Bump actions/checkout from 3 to 4](https://github.com/esaio/esa-ruby/pull/61)
- ci: [Add github-actions to Dependabot](https://github.com/esaio/esa-ruby/pull/60)

## 2.0.0 (2023-04-06)

- :warning: breaking: [Support Faraday 2.0.1+ by fukayatsu · Pull Request #58 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/58)
  - Drop support for Ruby < 2.7.0
  - Drop support for Faraday < 2.0.1

## 1.18.0 (2020-10-19)

- add: [Relax dependencies by fukayatsu · Pull Request #47 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/47)

## 1.17.0 (2020-07-02)

- ci: [Add specs for default_headers](https://github.com/esaio/esa-ruby/pull/45)
- add: [Add Post Append API (beta) by fukayatsu · Pull Request #46 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/46)
- **changed**: Drop support for Ruby 2.4

## 1.16.0 (2020-01-20)

- add: [Enable to set default_headers by fukayatsu · Pull Request #43 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/43)

## 1.15.0 (2019-12-27)

- add: [Add ApiMethods#delete_member by fukayatsu · Pull Request #40 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/40)
- ci: [Use github actions for CI by fukayatsu · Pull Request #38 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/38)
- ci: [Update development environment by fukayatsu · Pull Request #37 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/37)

## 1.14.0 (2018-12-13)

- changed: [Relax gem dependencies by ppworks · Pull Request #35 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/35)

## 1.13.0 (2017-11-01)

- **changed**: [Retry on rate limit exceeded by default by fukayatsu · Pull Request #31 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/31)
  - Use `Esa::Client.new(retry_on_rate_limit_exceeded: false, ...)` for previous behavior.
- doc: [Fixed README typo by polidog · Pull Request #30 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/30)

## 1.12.0 (2017-10-03)

- add: [Support /api/v1/comments API by ppworks · Pull Request #29 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/29)

## 1.11.0 (2017-09-04)

- add: [Support emoji API by ppworks · Pull Request #28 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/28)

## 1.10.0 (2017-08-22)

- add: [Support invitation API by ppworks · Pull Request #27 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/27)

## 1.9.0 (2017-08-02)

- add: [Enable to set headers for remote url on #upload_attachment by nownabe · Pull Request #26 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/26)

## 1.8.0 (2017-02-25)

- add: [Add batch_move_category API by fukayatsu · Pull Request #25 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/25)

## 1.7.0 (2016-08-16)

- add: [Support signed_url API by fukayatsu · Pull Request #24 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/24)
- fix: [Fix a typo by ksss · Pull Request #23 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/23)

## 1.6.0 (2016-06-10)

- add: [Add Categories API and Tags API by fukayatsu · Pull Request #22 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/22)

## 1.5.0 (2016-05-05)

- add: [Add Reaction APIs: star&watch by fukayatsu · Pull Request #20 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/20)

## 1.4.0 (2016-04-17)

- add: [Add Authenticated User API by fukayatsu · Pull Request #19 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/19)

## 1.3.0 (2016-02-09)

- add: [Add Sharing API by fukayatsu · Pull Request #17 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/17)

## 1.2.0 (2015-12-03)

- add: [Add Members API by fukayatsu · Pull Request #16 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/16)

## 1.1.2 (2015-10-05)

- fix: [Esa::Client#upload_attachment needs 'multi_xml' gem by ppworks · Pull Request #15 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/15)

## 1.1.1 (2015-10-01)

- add: [Enable to set cookie for remote url on #upload_attachment by fukayatsu · Pull Request #14 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/14)

## 1.1.0 (2015-10-01)

- add: [Enable to Upload Attachment by fukayatsu · Pull Request #13 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/13)

## 1.0.0 (2015-09-25)

- Production Ready (\\( ⁰⊖⁰)/)
- [Add Stats API by fukayatsu · Pull Request #12 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/12)
- [Use Travis CI for testing by hanachin · Pull Request #11 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/11)

## 0.0.6 (2015-06-21)

- [Support Comment API by fukayatsu · Pull Request #9 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/9)

## 0.0.5 (2015-05-21)

- [Use current_team! instead of current_team by fukayatsu · Pull Request #8 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/8)

## 0.0.4 (2015-05-14)

- [Fix Esa::Response#headers and implement its spec by yasaichi · Pull Request #7 · esaio/esa-ruby](https://github.com/esaio/esa-ruby/pull/7)
