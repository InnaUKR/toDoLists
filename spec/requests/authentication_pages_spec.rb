require 'rails_helper'

describe "Website access" do
  context "when I am a registered user" do
    it "should let me in" do
      page.fill_in 'Email',    with: 'vader@deathstar.com'
      page.fill_in 'Password', with: 'mydearluke'
      page.click_link 'Let me in'

      page.should have_content('Welcome, cheif!')
    end
  end

  context "when I am not a registered user" do
    it "should not let me in" do
      page.fill_in 'Email',    with: 'jabba.h@tatooine.com'
      page.fill_in 'Password', with: 'wormsarmageddon'
      page.click_link 'Let me in'

      page.should have_content('div.alert.alert-error')
    end
  end    

  context "after visiting another page" do
    before {click_link "Home"}
    it {should_not have_selector('div.alert.alert-error')}
  end  

  describe "Authentication" do
  describe "signin" do

    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') }

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
  end
end
end
