#
# Cookbook Name:: hello
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

log "hello chef!!!"
log node[:platform]

# make jenkins-repo file
template "jenkins.repo" do
  path "/etc/yum.repos.d/jenkins.repo"
  source "jenkins.repo"
end

execute "rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key"

%w(java-1.7.0-openjdk jenkins).each do |pkg|
  package pkg do
    action :install
  end
end

service "jenkins" do
  action [:start]
  supports Hash[*[:status, :restart, :reload].product([true]).flatten]
end  
