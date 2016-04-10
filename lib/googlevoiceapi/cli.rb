require 'googlevoiceapi'
require 'optparse'

module GoogleVoice
  class CLI
  
    def initialize(args)
      @args = args
    end
    
    def run
      options = {}

      optparse = OptionParser.new do |opts|

        opts.on('-u U', '--username U', 'Account username (optional)') do |username|
          options[:username] = username
        end

        opts.on('--call', 'Connect a call: [number from] [number to]') do
          options[:call] = true
        end

        opts.on('--sms', 'Send SMS message: [number to]') do
          options[:sms] = true
        end

        opts.on('--smstext T', 'SMS message text (Optional)') do |smstext|
          options[:smstext] = smstext
        end

        opts.on('-h', '--help', 'Print help') do
          STDERR.puts optparse
          exit 1
        end

      end

      optparse.parse!(@args)

      if options[:help]
        STDERR.puts optparse
        exit 1
      end

      unless options[:call] || options[:get_number] || options[:sms]
        STDERR.puts "Missing command: [call, sms]"
        STDERR.puts optparse
        exit 1
      end

      unless options[:username]
        print "Username: "
        options[:username] = STDIN.gets.chomp;
      end

      print "Password: "
      begin
        system "stty -echo"
        options[:password] = STDIN.gets.chomp; puts "\n"
      ensure
        system "stty echo"
      end

      gv = GoogleVoice::Api.new(options[:username], options[:password])
      if options[:call]
        if @args.length != 2
          STDERR.puts "Invalid call parameters: [number from] [number to]"
          STDERR.puts optparse
          exit 1
        end
        gv.call(@args[0], @args[1])
      elsif options[:sms]
        unless options[:smstext]
          print "SMS Text: "
          options[:smstext] = STDIN.gets.chomp!
        end
        if @args.length != 1
          STDERR.puts "Invalid sms parameter: [number to]"
          STDERR.puts optparse
          exit 1
        end
        gv.sms(@args[0], options[:smstext])
      end

    end
    
  end
end
