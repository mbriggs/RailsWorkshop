require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe UsersHelper do
  describe "gravatar_url" do
    it "should generate gravatar url" do
      email = "Test@Example.Com"
      md5 = Digest::MD5::hexdigest email.downcase
      url = "http://www.gravatar.com/avatar.php?gravatar_id=#{md5}"

      gravatar_url(email).should == url
      gravatar_url(email.upcase).should == url
      gravatar_url(email.downcase).should == url
    end
  end

  describe "current_user" do
    it "should return current user" do
      user = User.create! :username => "user", :password => "pass", :email => "user@example.com"
      session[:user] = user
      current_user.should == user
    end
  end
end
