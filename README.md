# Hello World through the AWS CLI

This codebase automates provisioning of an HTTP service on AWS. Visit a demonstration at http://tbd/hello to see the `Hello World` response. The web service runs on Ubuntu 14.04 LTS and joins a Chef organization [“AWS Chef Demo”](https://54.191.229.20/organizations/aws-chef-demo) without supervision on boot.

The Chef Server version is `12.4.1-1` (from https://docs.chef.io/aws_marketplace.html).

# Development Reference

## Dependencies

1. [Chef Development Kit](https://downloads.chef.io/chef-dk/); version `~> 0.13.21`
2. Ruby ([rbenv](https://github.com/rbenv/rbenv) preferred; [RVM](https://rvm.io/) untested but assumed interoperable)
3. [Bundler gem](http://bundler.io/)

### Installation

1. Install Ruby with `rbenv install` (confirm `ruby -v` returns a value agreeing with `.ruby-version`)
2. Install gems with `gem install bundler && bundle` (ignore `undefined method 'refresh' for #<Bundler::RubygemsIntegration::MoreFuture:0x007faeba0b3a18> (NoMethodError)`)
3. Set up a reference Chef Server using [AWS Marketplace instructions](https://docs.chef.io/aws_marketplace.html)
4. Place the PEM keypairs from the marketplace-built EC2 instance and the configured Chef Server application into this repository’s `config` directory
5. Test with connectivity with `knife ssl fetch && knife client list`

Success at step five should return:

```
MBP15RP:aws_cli_hello_world reidparham$ knife ssl fetch
WARNING: Certificates from ec2-54-191-229-20.us-west-2.compute.amazonaws.com will be fetched and placed in your trusted_cert
directory (/Users/reidparham/Codebase/aws_cli_hello_world/.chef/trusted_certs).

Knife has no means to verify these are the correct certificates. You should
verify the authenticity of these certificates after downloading.

Adding certificate for ec2-54-191-229-20.us-west-2.compute.amazonaws.com in /Users/reidparham/Codebase/aws_cli_hello_world/.chef/trusted_certs/ec2-54-191-229-20_us-west-2_compute_amazonaws_com.crt

MBP15RP:aws_cli_hello_world reidparham$ knife client list
aws-chef-demo-validator
```

## Command Reference

`rbenv install`

`bundle exec rake deploy production`

`bundle exec rake test`
