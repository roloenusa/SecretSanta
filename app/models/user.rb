require 'digest'
class User < ActiveRecord::Base
  
  attr_accessible :nombre, :email, :escogido, :amigo
  
  before_save :generate_hash
  
  def generate_friend
    posibilities = User.find(:all, :conditions => ["nombre != ? and escogido = ?", self.nombre, false ])
    amigo = posibilities.sample
    amigo.update_attributes(:escogido => true)
    self.update_attributes(:amigo => amigo.id)
  end
  
  def self.shuffle
    users = User.all
    amigos = User.all
    sentinel = true
    
    while sentinel
      amigos.shuffle!
      same = false
      users.each_with_index do |user, index|
        if user.id == amigos[index].id
          same = true
          break
        end
      end
      sentinel = same
    end

    users.each_with_index do |user, index|
      user.update_attributes(:amigo => amigos[index].id)
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
