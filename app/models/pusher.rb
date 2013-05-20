class Pusher < ActiveRecord::Base
  
  before_create :create_application_token

  attr_accessible :identifier 
  attr_protected :key

  
  validates :identifier, presence: true, uniqueness: true

  def create_application_token
  	self.application_token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
