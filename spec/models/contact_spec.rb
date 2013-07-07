require 'spec_helper'

describe Contact do
  
  let(:contact) do
    contact = Contact.new
    contact.name = "Stuart"
    contact.email = "stuart@example.com"
    contact.subject = "I want to throw money at you"
    contact.body = "Me need website"
    contact
  end
  
  describe "Validations" do
    
    it "should validate presence of name" do
      contact.name = nil
      contact.should_not be_valid
    end
    
    it "should validate presence of subject" do
      contact.subject = nil
      contact.should_not be_valid
    end
    
    it "should validate presence of body" do
      contact.body = nil
      contact.should_not be_valid
    end
    
    it "should validate presence of email" do
      contact.email = nil
      contact.should_not be_valid
    end
    
    it "should validate format of email" do
      contact.email = "stuart"
      contact.should_not be_valid
      contact.email = "@example.com"
      contact.should_not be_valid
      contact.email = "stuart@example.com"
      contact.should be_valid
    end
    
  end
  
  describe "initialize from hash" do
    
    let(:values) { { name: "Stuart", email: "stuart@example.com", subject: "I want to throw money at you", body: "Me need website" } }
    
    it "should initialize from a hash of values" do
      contact = Contact.new(values)
      contact.name.should == "Stuart"
      contact.body.should == "Me need website"
    end
    
  end
  
end