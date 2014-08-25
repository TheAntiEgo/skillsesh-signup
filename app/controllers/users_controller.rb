class UsersController < ApplicationController
  def new
    @users = User.all
  end

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.persisted?
      redirect_to edit_user_path(user)
    else
      redirect_to action: :new, alert: "Something went wrong! Try again or give us a hollar for help"
    end
  end

  def update
    User.find(params[:id]).update(get_params)
    redirect_to action: :new, notice: "Welcome to Skillsesh!"
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def get_params
    params.require(:user).permit(:id, :bio, :teachables, :learnables)
  end
end
