describe "User pages" do
  subject{ page }
  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	before { visit user_path(user) }
    it {should have_content(user.email)}
  	it {should have_title(user.email)}
	end

  describe "signup page" do
  	before { visit signup_path }
  	it { should have_content('Sign up')}
  	it { should have_title(full_title('Sign up'))}
  end

  describe "signup page" do
  	before { visit signup_path }
  	let(:submit) {"Create my account"}

  describe "with invalid information" do
  	it "should not create a user" do
  	 expect {click_button submit }.not_to change(User, :count)
    end
  end
  
  describe "with valid information" do
  	before do
  		fill_in "Email", with: "example@example.com"
  		fill_in "Password", with: "password"
  		fill_in "Password_confirmation", with: "password"
  	end
  	it "should create a user" do
  	 expect {click_button submit}.to change(User, :count).by(1)
  	end
  end
  end
end