module Waz
  module Cmd
    begin
      require 'faster_require' if RUBY_PLATFORM =~ /win32|mingw32/
    rescue
      puts 'WARNING: Waz will run faster on Windows if you install the "faster_require" gem.'
    end
    require 'rexml/document'
    require 'rexml/xpath'
    require 'iconv'
    begin
      require 'Win32/Console/ANSI' if RUBY_PLATFORM =~ /win32|mingw32/
    rescue
      puts 'WARNING: Output will look weird on Windows unless you install the "win32console" gem.'
    end
    require 'openssl'
    require 'rest_client'
    require 'tilt'
    require 'base64'
    require 'yaml'
    require 'crack'
    require 'nokogiri'

    def set_defaults(options)
      options.default :pem => "#{ENV['HOME']}/.waz/cert.pem", :cer => "#{ENV['HOME']}/.waz/cert.cer", :key => "#{ENV['HOME']}/.waz/key.pem"
      options.default :subscriptionId => $config['subscriptionId'] if $config['subscriptionId']
    end

    def make_call(path, method, options, body=nil)
      headers = { 'x-ms-version' => '2011-06-01' }
      headers['Content-Type'] = 'application/xml' unless body.nil?
      options = {
        :url => "https://management.core.windows.net/#{options.subscriptionId}/#{path}",
        :method => method,
        :headers => headers,
        :ssl_client_cert => OpenSSL::X509::Certificate.new(File.read(options.pem)),
        :ssl_client_key => OpenSSL::PKey::RSA.new(File.read(options.key))
      }
      options[:payload] = body unless body.nil?
      if block_given?
        yield RestClient::Request.execute options
      else
        Crack::XML.parse RestClient::Request.execute options
      end
    end

    def arrayize(x)
      return [] if x.nil?
      return x if x.kind_of?(Array)
      return [x]
    end

    def restar_instance(star)
      command "re#{star} instance" do |c|
        c.syntax = "waz re#{star} instance <application> <production|staging> <instance> [options]"
        c.description = "Re#{star} the specified instance"
        c.action do |args, options|
          set_defaults options
          raise 'Subscription ID is required' unless options.subscriptionId
          raise 'Application name is required' unless args[0]
          raise 'Deployment name is required' unless args[1]
          raise 'Instance name is required' unless args[2]
          make_call("services/hostedservices/#{args[0]}/deploymentslots/#{args[1]}/roleinstances/#{args[2]}?comp=re#{star}", :post, options, '') do |response|
            wait_for_completion options, response.headers[:x_ms_request_id]
          end
        end
      end
    end

    def startstop(verb, status)
      command verb do |c|
        c.syntax = "waz #{verb} <application> <production|staging> [options]"
        c.description = "#{verb.capitalize} the deployment in the specified slot of the specified application"
        c.action do |args, options|
          set_defaults options
          raise 'Subscription ID is required' unless options.subscriptionId
          raise 'Application name is required' unless args[0]
          raise 'Deployment slot is required' unless args[1]

          make_call("services/hostedservices/#{args[0]}/deploymentslots/#{args[1]}/?comp=status", :post, options,
            Nokogiri::XML::Builder.new(:encoding => 'utf-8') { |xml|
              xml.UpdateDeploymentStatus('xmlns' => 'http://schemas.microsoft.com/windowsazure') {
                xml.Status status
              }
            }.to_xml) do |response|
            wait_for_completion options, response.headers[:x_ms_request_id]
          end
        end
      end
    end

    def wait_for_completion(options, requestId)
      puts 'Waiting for operation to complete...'
      done = false
      while not done
        status = make_call("operations/#{requestId}", :get, options)['Operation']
        done = status['Status'] != 'InProgress'
        if done
          puts "Operation #{status['Status'].downcase} (#{status['HttpStatusCode']})"
          if status['Error']
              puts "#{status['Error']['Code']}: #{status['Error']['Message']}"
          end
        else
          sleep 10
        end
      end
    end
  end
end
