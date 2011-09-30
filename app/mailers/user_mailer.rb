class UserMailer < ActionMailer::Base
  default :from => "roloenusa@msn.com"
  
  def email_link(user)
    @user = user
    @url  = "#{users_url}/#{@user.secreto}"
    mail(:to => user.email, :subject => "El Amigo Secreto 2011")
  end
end
