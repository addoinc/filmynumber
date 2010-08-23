class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.login_field = :email
  end
  
  validates_presence_of :login
  validates_length_of :login, :minimum => 4
  validates_uniqueness_of :login
  
  has_many :opinions
end
