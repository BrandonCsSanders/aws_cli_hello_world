# Hello World through the AWS CLI

This codebase automates provisioning of an HTTP service on AWS. Visit a demonstration at http://52.11.71.100/hello to see the `Hello World` response. The web service runs on Ubuntu 14.04 LTS and joins a Chef organization [“AWS Chef Demo”](https://54.191.229.20/organizations/aws-chef-demo) without supervision on boot.

The Chef Server version is `12.4.1-1` (from https://docs.chef.io/aws_marketplace.html).

# Development Reference

## Dependencies

1. Ruby ([rbenv](https://github.com/rbenv/rbenv) preferred; [RVM](https://rvm.io/) untested but assumed interoperable)
2. [Bundler gem](http://bundler.io/)

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

## Configuration

1. Obtain Access Keys using instructions in https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html
2. Rename file `config/secrets-example.yml` as `config/secrets.yml`
3. Replace the contents of `secrets.yml` with the values obtained in step 1
4. Run `knife ec2 server list` to check for a working Knife EC2 configuration

Success at step four should return:

```
MBP15RP:aws_cli_hello_world reidparham$ knife ec2 server list
Instance ID  Name  Public IP      Private IP     Flavor     Image         SSH Key        Security Groups  IAM Profile    State
i-redacted         54.191.229.20  172.31.46.169  t2.medium  ami-redacted  aws-chef-demo  launch-wizard-1  Chef-EC2-Demo  running
```

Error messages at step four should be informative; example:

```
MBP15RP:aws_cli_hello_world reidparham$ knife ec2 server list
ERROR: You did not provide a valid 'AWS Access Key Id' value.
ERROR: You did not provide a valid 'AWS Secret Access Key' value.
```

# Operations

## Build a target machine

Using the [Ubuntu Amazon EC2 AMI Locator](https://cloud-images.ubuntu.com/locator/ec2/) shows that `ami-50946030` is the target AMI. With SSH key `MBPRP15` and desired instance size `t2.micro`, the provisioning call becomes:

```
knife ec2 server create \
-V \
-I ami-50946030 \
--ssh-key parhamr-on-chef-demo \
-f t2.micro \
--ssh-user ubuntu \
--user parhamr \
--identity-file ./.chef/parhamr.pem \
--region us-west-2 \
--associate-public-ip \
--associate-eip 52.11.71.100 \
--subnet subnet-6daa661b \
--server-connect-attribute public_ip_address \
--ebs-size 10 \
--ebs-volume-type gp2 \
--security-group-ids sg-6a02380d \
--server-url https://54.191.229.20/organizations/aws-chef-demo \
--no-node-verify-api-cert \
--no-host-key-verify \
--node-ssl-verify-mode none \
--run-list "recipe[nginx]"
```

Note that the `knife ec2` commands use `--identity-file` but other Knife commands (e.g. `bootstrap`) have deprecated that option in favor of `--ssh-identity-file`.


Helpful links:

 - http://clarkdave.net/2013/05/creating-ec2-instances-in-an-amazon-vpc-using-chef-and-knife/
 - https://stackoverflow.com/questions/16451762/using-knife-ec2-plugin-to-create-vm-in-vpc-private-subnet
 - https://stackoverflow.com/questions/19701648/how-to-launch-amazon-ec2-instance-inside-vpc-using-chef-without-using-a-gateway

Command to test bootstrapping:

```
knife bootstrap 52.11.71.100 \
-N i-09e7555c14bae2f27 \
--server-url https://54.191.229.20/organizations/aws-chef-demo \
--ssh-identity-file ./.chef/parhamr.pem \
--key ./.chef/parhamr.pem \
--no-node-verify-api-cert \
--no-host-key-verify \
--node-ssl-verify-mode none \
--run-list "recipe[nginx]" \
--ssh-user ubuntu \
--user parhamr \
-V
```
