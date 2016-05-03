# See https://docs.chef.io/aws_marketplace.html/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "parhamr"
client_key               "#{current_dir}/parhamr.pem"
validation_client_name   "aws-chef-demo-validator"
validation_key           "#{current_dir}/aws-chef-demo-validator.pem"
chef_server_url          "https://ec2-54-191-229-20.us-west-2.compute.amazonaws.com/organizations/aws-chef-demo"
cookbook_path            ["#{current_dir}/../cookbooks"]
