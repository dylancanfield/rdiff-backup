# default attributes
node.default['rdiff-backup']['client']['ssh-port'] = "22"
node.default['rdiff-backup']['client']['source-dirs'] = ["/etc", "/var/log"]
node.default['rdiff-backup']['client']['destination-dir'] = "/data/rdiff-backup"
node.default['rdiff-backup']['client']['retention-period'] = "3M"
node.default['rdiff-backup']['client']['additional-args'] = ""
node.default['rdiff-backup']['client']['user'] = "rdiff-backup-client"
node.default['users'] = [node['rdiff-backup']['client']['user']]
node.default['authorization']['sudo']['users'] = [node['rdiff-backup']['client']['user']]