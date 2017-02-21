class UsersController < ApplicationController
	#def show
		#@user = User.find(params[:id])
    #@projects = @user.projects.paginate(page: params[:page])
  	#end
  	
    def new
    	@user = User.new
  	end	

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to root_url
    else
      render 'new'
    end
  end


  private

    def user_params
      params.require(:user).permit(:email, :password,
                                   :password_confirmation)
    end
end
