class Pusher < ActiveRecord::Base
  
  before_create :create_application_token

  attr_accessible :identifier 
  attr_protected :key

  belongs_to :application
  
  validates :identifier, presence: true, uniqueness: true

  def create_application_token
  	self.key = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end