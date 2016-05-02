# Hello World through the AWS CLI

This codebase automates provisioning of an HTTP service on AWS. Visit a demonstration at http://tbd/hello to see the `Hello World` response. The web service runs on Ubuntu 14.04 LTS and joins the Chef organization `default` without supervision on boot.

# Development Reference

## Dependencies

1. Ruby ([rbenv](https://github.com/rbenv/rbenv) preferred; [RVM](https://rvm.io/) untested but assumed interoperable)
2. [Bundler gem](http://bundler.io/)
3. [Rake gem](https://github.com/ruby/rake)
4. [`aws-sdk` gem](https://aws.amazon.com/sdk-for-ruby/)

## Command Reference

`bundle exec rake deploy production`

`bundle exec rake test`
