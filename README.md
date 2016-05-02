# Hello World through the AWS CLI

This codebase automates provisioning of an HTTP service on AWS. Visit a demonstration at http://tbd/hello to see the `Hello World` response. The web service runs on Ubuntu 14.04 LTS and joins a Chef organization [“AWS Chef Demo”](https://54.191.229.20/organizations/aws-chef-demo) without supervision on boot.

The Chef Server version is `12.4.1-1`.

# Development Reference

## Dependencies

1. Ruby ([rbenv](https://github.com/rbenv/rbenv) preferred; [RVM](https://rvm.io/) untested but assumed interoperable)
2. [Bundler gem](http://bundler.io/)
3. [Rake gem](https://github.com/ruby/rake)
4. [`aws-sdk` gem](https://aws.amazon.com/sdk-for-ruby/)

## Command Reference

`rbenv install`

`bundle exec rake deploy production`

`bundle exec rake test`
