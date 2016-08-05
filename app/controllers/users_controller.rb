class UsersController < ApplicationController
    def update_profile_pic
      current_user.update(user_profile_pic_params)
      redirect_to edit_user_registration_url and return
    end

    def remove_profile_pic
      current_user.profile_pic = nil
      redirect_to my_profile_edit_url
    end

    def update_with_password
      user=current_user
      if current_user.update_with_password(user_password_params)
        flash[:now]= 'Password successfully updated.'
        sign_in(user, :bypass => true)
      else
        flash[:error]="Password update failed, because of #{current_user.errors.full_messages.join('. ')}"
      end
      redirect_to :back
    end

    def update_without_password
      if current_user.update(user_email_params)
        if current_user.previous_changes[:email].class == Array
          current_user.confirmed_at=nil
          current_user.save
          current_user.send_confirmation_instructions
        end
        flash[:now]='Profile successfully updated.'
      else
        flash[:error]="Profile update failed, because of#{current_user.errors.full_messages.join('. ')}"
      end
      redirect_to :back
    end

    private
    def user_password_params
      params.require(:user).permit(:id, :password, :password_confirmation, :current_password)
    end

    def user_email_params
      params.require(:user).permit(:id, :first_name, :last_name, :email)
    end

    def user_profile_pic_params
      params.require(:user).permit(:id, :profile_pic)
    end
  end