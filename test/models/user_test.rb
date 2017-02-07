require 'spec_helper'

class UserTest < ActiveSupport::TestCase
	descibe User do
		before{ @user = User.new(name: "Example User", email: "user@example.com")}
		#it "should respond to 'name'" do
		#	expact(@user).to respond_to(:name)
		#end
		subject {@user}

		it {should respond_to(:name)}
		it {should respond_to(:email)}

		end
	end
end
