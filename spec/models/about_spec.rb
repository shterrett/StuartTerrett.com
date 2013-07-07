require 'spec_helper'

describe About do

  it "should initialize a single instance on startup if one does not currently exist" do
    About.all.length.should == 1
  end

end
