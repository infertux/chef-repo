file_cache_path           "/root/chef/cache"
data_bag_path             "/root/chef/data_bags"
cookbook_path             [ "/root/chef/site-cookbooks", "/root/chef/cookbooks" ]
role_path                 "/root/chef/roles"

log_level :info
log_location STDOUT
ssl_verify_mode :verify_peer
