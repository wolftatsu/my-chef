log 'install emacs'
log node['emacs']['site_url']

directory node['emacs']['working_dir'] do
  action :create
end

bash 'install-emacs' do
  action :nothing
  cwd node['emacs']['working_dir']
  code <<-END
tar xzvf #{node['emacs']['file_name']}
cd #{File.basename(node['emacs']['file_name'], '.tar.gz')}
./configure
make
make install
END
end

remote_file File.join(node['emacs']['working_dir'], node['emacs']['file_name']) do
  action :create_if_missing
  source node['emacs']['site_url'] + node['emacs']['file_name']
  notifies :run, 'bash[install-emacs]', :immediately
end  
