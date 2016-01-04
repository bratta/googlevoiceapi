require 'rubygems'
require 'mechanize'
require 'htmlentities'

require File.dirname(__FILE__) + '/googlevoiceapi/version'


# This gem provides a Ruby API for working with Google Voice. Right now
# there is no public API provided by Google, so we are relying on
# mechanize to log into the site and use some restful web services to
# work with the data. The calls were provided at this pagE:
# http://posttopic.com/topic/google-voice-add-on-development
# and this class will implement all the methods outlined there.
module GoogleVoice
  class Api
    attr_accessor :email, :password, :agent, :rnr_se, :coder

    class InvalidLoginException < Exception; end
    class InvalidPhoneNumberException < Exception; end

    # Create a basic Mechanize agent, initial our objects, and
    # create our dynamic <function>_xml methods
    def initialize(email=nil, password=nil)
      @agent = Mechanize.new
      @coder = HTMLEntities.new
      @email = email if !email.nil?
      @password = password if !password.nil?

      # The methods created with this are used to fetch various
      # XML data from Google for call-related history data.
      init_xml_methods()

      init_json_methods()
    end

    # Login to a Google Account to use the Google Voice services
    # Most of the calls require a special authentication token called
    # _rnr_se that can be scraped from the page once logged in.
    def login()
      login_page = @agent.get("https://www.google.com/accounts/ServiceLogin?service=grandcentral")
      login_page.forms.first.field_with(:name=>"Email").value = @email
      login_page.forms.first.field_with(:name=>"Passwd").value = @password
      agent.submit(login_page.forms.first)
      page = @agent.get('https://www.google.com/voice/')
      dialing_form = page.forms.find { |f| f.has_field?('_rnr_se') }
      raise InvalidLoginException, "Cannot login to Google Voice with #{@email}" unless dialing_form
      @rnr_se = dialing_form.field_with(:name => '_rnr_se').value
    end

    # Make sure we have a valid Mechanize agent and we obtained the _rnr_se
    # authentication token after logging in. Those are the two keys to
    # determining if we are successfully logged in or not.
    def logged_in?
        (@agent !=nil) && (@rnr_se != nil)
    end

    # Send a text message to remote_number
    def sms(remote_number, text_message)
      login unless logged_in?
      remote_number = validate_number(remote_number)
      text_message = @coder.encode(text_message)
      @agent.post('https://www.google.com/voice/sms/send/', :id => '', :phoneNumber => remote_number, :text => text_message, "_rnr_se" => @rnr_se)
    end

    # Place a call to remote_number, and ring back forwarding_number which
    # should be set up on the currently logged in Google Voice account
    def call(remote_number, forwarding_number)
      login unless logged_in?
      remote_number = validate_number(remote_number)
      forwarding_number = validate_number(forwarding_number)
      @agent.post('https://www.google.com/voice/call/connect/', :outgoingNumber => remote_number, :forwardingNumber => forwarding_number, :phoneType => 2, :subscriberNumber => 'undefined', :remember => '0', "_rnr_se" => @rnr_se)
    end

    # Cancel the call in progress for this account. It does NOT hang up
    # a call that has been answered, only one that has been placed but
    # not completed yet.
    def cancel()
      login unless logged_in?
      @agent.post('https://www.google.com/voice/call/cancel/', :outgoingNumber => 'undefined', :forwardingNumber => 'undefined', :cancelType => 'C2C', "_rnr_se" => @rnr_se)
    end


    # International numbers can vary in length as opposed to the standard US 10 digit number
    # So we can't effectively validate based on length. Instead, let's make sure we have at
    # least 4 digits and at most 15 since E.164 recommends at most 15 digits minus country code
    # for the phone number (http://en.wikipedia.org/wiki/E.164)
    def validate_number(phone_number)
      phone_number = phone_number.gsub(/\D/,'')
      raise InvalidPhoneNumberException, "Invalid Phone Number #{phone_number}" if phone_number.length < 4 || phone_number.length > 15
      phone_number
    end

    private

    # Login if it hasn't been done yet, then GET the particular URL
    def get_xml_document(url)
      login unless logged_in?
      @agent.get(url).body
    end

    # Google provides XML data for various call histories all with the same
    # URL pattern in a getful manner. So here we're just dynamically creating
    # methods to fetch that data in a DRY-manner. Yes, define_method is slow,
    # but we're already making web calls which drags performance down anyway
    # so it shouldn't matter in the long run.
    def init_xml_methods()
      (class << self; self; end).class_eval do
        %w{ unread inbox starred all spam trash voicemail sms trash recorded placed received missed }.each do |method|
          define_method "#{method}_xml".to_sym do
            get_xml_document("https://www.google.com/voice/inbox/recent/#{method}")
          end
        end
      end
    end

    # Google voice also appears to have undocumented json outputs.
    # https://www.google.com/voice/request/contacts http://google.com/voice/request/messages
    # much easier to deal with than XML

    def init_json_methods()
      (class << self; self; end).class_eval do
        %w{ contacts messages }.each do |method|
          define_method "#{method}_json".to_sym do
            get_xml_document("https://www.google.com/voice/request/#{method}")
          end
        end
      end
    end
  end
end
