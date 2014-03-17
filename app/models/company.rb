require "bcrypt"

class Company < ActiveRecord::Base
  attr_accessible :email, :password, :name, :password_confirmation

  validates_presence_of :email, :password, :name
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 6
  validates_confirmation_of :password

  def password=(new_password)
  	@password = new_password
  	self.encrypted_password = BCrypt::Password.create(new_password)
  end

  def password
  	@password
  end

  def valid_passoword?(password_to_validate)
  	BCrypt::Password.new(password_to_validate) == encrypted_password
  	
  end
end
