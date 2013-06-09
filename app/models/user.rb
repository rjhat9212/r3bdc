class User < ActiveRecord::Base
  rolify

  devise :omniauthable, :omniauth_providers => [:facebook, :google_oauth2]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  attr_accessible :role_ids, :as => :admin
  attr_accessible :provider, :uid, :name
  # attr_accessible :title, :body

  validates_uniqueness_of :email, :case_sensitive => false
  validates_presence_of :name

  class << self
    def find_for_facebook_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        user = User.create(name:     auth.extra.raw_info.name,
                           provider: auth.provider,
                           uid:      auth.uid,
                           email:    auth.info.email,
                           password: Devise.friendly_token[0,20]
        )
      end
      user
    end
    def find_for_google_oauth(auth, signed_in_resource=nil)
      user = User.where(:provider => auth.provider, :uid => auth.uid).first
      unless user
        user = User.create(name:     auth.extra.raw_info.name,
                           provider: auth.provider,
                           uid:      auth.uid,
                           email:    auth.info.email,
                           password: Devise.friendly_token[0,20]
        )
      end
      user
    end
    def new_with_session(params, session)
      super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
          user.email = data["email"] if user.email.blank?
        end
      end
    end
  end
end
