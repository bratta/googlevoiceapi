require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))
require 'googlevoiceapi'

describe GoogleVoice::Api, " When working with validations" do
  before(:each) do
    @api = GoogleVoice::Api.new(GVConfig.username, GVConfig.password)
  end

  it "should return a valid phone number" do
    pn = '1234567890'
    @api.validate_number(pn).should == '1234567890'
  end

  it "should strip characters properly from a phone number" do
    pn = '+1 (405) 599-1234'
    @api.validate_number(pn).should == '14055991234'
  end

  it "should raise an exception with an invalid number" do
    pn = 'invalid number'
    lambda { @api.validate_number(pn) }.should raise_error(GoogleVoice::Api::InvalidPhoneNumberException)
  end
end

describe GoogleVoice::Api, " When dealing with basic functionality" do
  before(:each) do
    @api = GoogleVoice::Api.new(GVConfig.username, GVConfig.password)
  end

  it "should not be logged in before login method called" do
    @api.logged_in?.should == false
  end

  it "should login properly" do
    lambda { @api.login }.should_not raise_error(GoogleVoice::Api::InvalidLoginException)
    @api.logged_in?.should == true
  end

  it "should raise login exception on invalid credentials" do
    @api.password = 'some fake password'
    lambda { @api.login }.should raise_error(GoogleVoice::Api::InvalidLoginException)
    @api.logged_in?.should == false
  end
end

describe GoogleVoice::Api, " When dealing with phone functionality" do
  before(:each) do
    @api = GoogleVoice::Api.new(GVConfig.username, GVConfig.password)
    @remote_number = GVConfig.remote_number
    @forward_number = GVConfig.forward_number
  end

  it "should send a text message to Tim" do
    @api.sms(@remote_number, 'Test sms from rspec').should_not == nil
  end

  it "should place a call" do
    puts "Don't answer this call, stupid."
    @api.call(@remote_number, @forward_number).should_not == nil
  end

  it "should cancel the call" do
    @api.cancel.should_not == nil
  end

  it "should place a call that we can answer and not be cancelled" do
    @api.call(@remote_number, @forward_number).should_not == nil
    puts "NOW answer your dang phone, yo!"
    sleep 15
  end
end

describe GoogleVoice::Api, " When dealing with XML data feeds" do
  before(:each) do
    @api = GoogleVoice::Api.new(GVConfig.username, GVConfig.password)
  end

  %w{ unread inbox starred all spam trash voicemail sms trash recorded placed received missed }.each do |xml_action|
    it "should return XML for #{xml_action} items" do
      xml_method = "#{xml_action}_xml".to_sym
      @api.send(xml_method).should_not == nil
    end
  end

end

describe GoogleVoice::Api, " When dealing with json data feeds" do
  before(:each) do
    @api = GoogleVoice::Api.new(GVConfig.username, GVConfig.password)
  end

  %w{ messages contacts }.each do |json_action|
    it "should return json for #{json_action} items" do
      json_method = "#{json_action}_json".to_sym
      @api.send(json_method).should_not == nil
    end
  end

end
