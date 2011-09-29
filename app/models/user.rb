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
