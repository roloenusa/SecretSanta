require 'digest'
class User < ActiveRecord::Base
  
  attr_accessible :nombre, :email, :escogido, :amigo
  
  before_save :generate_hash
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :nombre,  :presence => true,
                    :length   => { :maximum => 20 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  
  def self.shuffle
    users = User.all
    amigos = User.all
    sentinel = true
    
    while sentinel
      amigos.shuffle!
      same = false
      users.each_with_index do |user, index|
        if self.rules(user, amigos[index])
          same = true
          break
        end
      end
      sentinel = same
    end

    users.each_with_index do |user, index|
      user.update_attributes(:amigo => amigos[index].id)
      # Turn off the emailer for all.
      # UserMailer.email_link(user).deliver
    end
  end 
  
  def self.rules(user, amigo)
    if (user.id == amigo.id) 
      puts "User id the same"
      return true
    elsif (user.nombre.downcase == 'laura' && amigo.nombre.downcase == 'mark') 
      puts "Laura y Mark"
      return true
    elsif (user.nombre.downcase == 'mark' && amigo.nombre.downcase == 'laura') 
        puts "Laura y Mark"
        return true
    elsif (user.nombre.downcase == 'juan' && amigo.nombre.downcase == 'danielle')
      puts "Juan y Danielle"
      return true
    end
  end
  
private

  def generate_hash
    self.secreto = encrypt(self.nombre)
  end
  
  def encrypt(string)
    secure_hash("#{string}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end
  
end
