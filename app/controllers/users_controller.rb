class UsersController < ApplicationController
  def new
    # @users = User.all.order('created_at DESC').limit(6)
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
    User.find(get_params[:id]).update(get_params)
    redirect_to action: :new, notice: "Welcome to Skillsesh!"
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def get_params
    params.permit(:id, :bio, :can_teach, :can_learn)
  end
end
