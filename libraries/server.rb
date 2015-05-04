class Chef
  class Resource
    class RdiffBackup < LWRPBase
      actions :add, :remove
      attribute :src, kind_of: String, default: '/'
      attribute :excludes, kind_of: Array, default: []
      attribute :dst, kind_of: String
      attribute :period, kind_of: String, default: "1W"
      attribute :args, kind_of: String, default: ''
      [:minute, :hour].each do |i|
        attribute i, kind_of: [String,Integer], default: 0
      end
      [:day, :month, :weekday].each do |i|
        attribute i, kind_of: [String,Integer], default: '*'
      end
      attribute :user, kind_of: String, default: 'rdiff-backup-server'
      attribute :remote_user, kind_of: String, default: 'rdiff-backup-client'
    end
  end
  class Provider
    class RdiffBackup < LWRPBase
      action :add do
        directory File.join('/home', new_resource.user, 'exclude') do
          owner suser
          group suser
          recursive true
        end

        template File.join('/home', new_resource.user, exclude, node['fqdn'] + "_" + new_resource.src.gsub('/','-')) do
          source 'job.sh.erb'
          owner new_resource.user
          group new_resource.user
          mode 0755
          recursive true
          variables(
            fqdn: node['fqdn'],
            src: new_resource.src,
            dest: new_resource.dst,
            suser: new_resource.user,
            period: new_resource.period,
            cuser: new_resource.remote_user,
            port: 22,
            args: new_resource.args
          )
        end
      end
    end
  end
end
