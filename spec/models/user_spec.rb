require 'rails_helper'

RSpec.describe User, type: :model do
    before { @user = User.new(email: "user@example.com", password: "foobar",
     password_confirmation:"foobar") }

  	subject { @user }

  	it { should respond_to(:email) }
  	it { should respond_to(:password_digest)}
  	it { should respond_to(:password)}
  	it { should respond_to(:password_confirmation)}

  	it {should be_valid}
  	it {should respond_to(:authenticate)}

	describe "when email is not present" do
		before {@user.email = " "}
	  	it {should_not be_valid}
	end

  	describe "when email address is aleready taken" do
  		before do
  			user_with_same_email = @user.dup
  			user_with_same_email.email = @user.email.upcase
  			user_with_same_email.save
  		end
  		it {should_not be_valid}
  	end

  	describe "when password is not present" do
  		before {@user.password = @user.password_confirmation = " "}
  		it{should_not be_valid}
  	end

  	describe "when password doesn't mach confirmation" do
  		before {@user.password_confirmation = "fall"}
  		it {should_not be_valid}
  	end

  	describe "with the password that's too short" do
  		before { @user.password_confirmation = "a" * 5}
  		it {should be_invalid}
  	end

  	describe "return value of authenticate metod" do
  		before { @user.save}
  		let(:found_user) {User.find_by(email: @user.email)}

  		describe "with valid password" do
  			it { should eq found_user.authenticate(@user.password) }
  		end

	    describe "with invalid password" do
	      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

	      it { should_not eq user_for_invalid_password }
	      specify { expect(user_for_invalid_password).to be_falsey }
	    end

  	end

end
