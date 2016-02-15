class UserMailer < ApplicationMailer
  default :from => "adminmail@snu.ac.kr"

  def activation_needed_email(user)
    @user = user
    @url = "http://snubooks.com/users/#{user.activation_token}/activate"
    mail(:to => "#{user.email}@snu.ac.kr", :subject => "Welcome to SNUBOOKS")
  end

  def activation_success_email(user)
    @user = user
    @url = "http://snubooks.com/login"
    mail(:to => "#{user.email}@snu.ac.kr",
         :subject => "Your account is now activated")
  end

  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(:to => "#{user.email}@snu.ac.kr",
         :subject => "Your password has been reset")
  end
end
