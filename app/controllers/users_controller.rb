class UsersController <ApplicationController 
    def new 
        @user = User.new()
    end 

    def show 
        @user = User.find(params[:id])
    end 

    def create 
        # binding.pry
        user = User.create(user_params)
        if user.save
            redirect_to user_path(user)
        else  
            flash[:error] = user.errors.full_messages.to_sentence
            redirect_to register_path
        end 
    end 

    def login_form

    end

    def login_user
        user = User.find_by(name: params[:name])
        if user.authenticate(params[:password])
            flash[:success] = "Welcome, #{user.name}!"
            redirect_to root_path
        else
            flash[:error] = "Password incorrect"
            render :login_form
        end
    end

    private 

    def user_params 
        params.require(:user).permit(:name, :email, :password_digest, :password, :password_confirmation)
    end 
end 