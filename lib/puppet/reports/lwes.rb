# Code based on jamtur01's puppet-ganglia plugin.
# https://github.com/jamtur01/puppet-ganglia
#
# Author: Shanker Balan <shanker.balan@inmobi.com>
#
# LICENSE: BSD

require 'puppet'
require 'yaml'

begin
  require 'lwes'
rescue LoadError => e
  Puppet.info "You need the `lwes` gem to use the LWES report"
end

Puppet::Reports.register_report(:lwes) do
  configfile = File.join([File.dirname(Puppet.settings[:config]), "lwes.yaml"])
  raise(Puppet::ParseError, "LWES report config file #{configfile} not readable") unless File.exist?(configfile)
  config = YAML.load_file(configfile)
  LWES_ADDRESS = config[:lwes_server]
  LWES_PORT = config[:lwes_port]
  LWES_TYPEDB = File.join([File.dirname(Puppet.settings[:config]), config[:typedb]])
  LWES_TTL = config[:ttl]
  LWES_HEARTBEAT = config[:heartbeat]

  desc <<-DESC
    Send notification of failed reports to a LWES server via lwes.
    DESC

    module MyApp
    end

    def process
        Puppet.notice "Sending status report to LWES server at #{LWES_ADDRESS}:#{LWES_PORT}"
          emitter = LWES::Emitter.new(:address => LWES_ADDRESS,
      :port => LWES_PORT,
      :heartbeat => LWES_HEARTBEAT,
      :ttl => LWES_TTL)

          type_db = LWES::TypeDB.new(LWES_TYPEDB)
    type_db.create_classes! :parent => MyApp
    my_event = MyApp::Metrics.new
    my_event.started = Time.now.to_i

    h = Hash.new

    i = 0
    self.metrics.each { |metric,data|
      data.values.each { |val|
        i += 1
        key = val[1].downcase + "_" + metric.downcase
        key.gsub!(/(\s+)/,"_")
        value = val[2]
        h[key] = value
        Puppet.debug "LWES #{i}: #{key}:#{value}"
      }
    }

    my_event.config_retrieval_time = h["config_retrieval_time"]
    my_event.filebucket_time = h["filebucket_time"]
    my_event.schedule_time = h["schedule_time"]
    my_event.total_time = h["total_time"]
    my_event.total_resources = h["total_resources"]
    my_event.total_events = h["total_events"]
    my_event.total_changes = h["total_changes"]

    my_event.finished = Time.now.to_i
    emitter.emit my_event
  end
end

# vim: set ts=2 sw=2 expandtab:
