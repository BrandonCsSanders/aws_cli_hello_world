# See https://docs.chef.io/aws_marketplace.html/config_rb_knife.html for more information on knife configuration options

# boilerplate configs
current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "parhamr"
client_key               "#{current_dir}/parhamr.pem"
validation_client_name   "aws-chef-demo-validator"
validation_key           "#{current_dir}/aws-chef-demo-validator.pem"
chef_server_url          "https://ec2-54-191-229-20.us-west-2.compute.amazonaws.com/organizations/aws-chef-demo"
cookbook_path            ["#{current_dir}/../cookbooks"]
# unfortunate but this prevents SSL Validation failure connecting to host: 54.191.229.20
ssl_verify_mode          :verify_none

# now add AWS-specific Knife configs
knife[:region]   = 'us-west-2'
aws_secrets      = {}
aws_secrets_path = File.expand_path("#{current_dir}/../config/secrets.yml")

# try to load the secrets file
if File.exist?(aws_secrets_path)
  aws_secrets = YAML.load(File.binread(aws_secrets_path))
else
  raise "Required file '#{aws_secrets_path}' not present! Please use it to securely store AWS Access Key ID and Secret."
end

# check YAML for well-formedness
if aws_secrets[:aws_access_key_id].nil? ||
  aws_secrets[:aws_access_key_id].empty? ||
  aws_secrets[:aws_secret_access_key].nil? ||
  aws_secrets[:aws_secret_access_key].empty?
  raise "Secrets file '#{aws_secrets_path}' does not contained well-formed AWS credentials! See https://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html"
end

# finally, set the AWS Knife configs
knife[:aws_access_key_id]     = aws_secrets[:aws_access_key_id]
knife[:aws_secret_access_key] = aws_secrets[:aws_secret_access_key]
