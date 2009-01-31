module Minimalist
  module Authentication
    def self.included( base )
      base.extend(ClassMethods)
      base.class_eval do
        include InstanceMethods
        
        attr_accessor :password
        attr_protected :crypted_password, :salt
        before_save :encrypt_password
        
        validates_presence_of :email
        validates_uniqueness_of :email
        
        named_scope :active, :conditions => {:active => true}
      end
    end
    
    module ClassMethods
      def authenticate(email, password)
        return if email.blank? || password.blank?
        user = active.first(:conditions => {:email => email})
        return unless user && user.authenticated?(password)
        update_all("last_logged_in_at='#{Time.now.to_s(:db)}'", "id=#{user.id}") # use update_all to avoid updated_on trigger
        return user
      end
      
      def secure_digest(*args)
        Digest::SHA1.hexdigest(args.flatten.join('--'))
      end

      def make_token
        secure_digest(Time.now, (1..10).map{ rand.to_s })
      end
    end
    
    module InstanceMethods
      
      def authenticated?(password)
        crypted_password == encrypt(password)
      end
      
      #######
      private
      #######
      
      def encrypt(password)
        self.class.secure_digest(password, salt)
      end
      
      def encrypt_password
        return if password.blank?
        self.salt = self.class.make_token if new_record?
        self.crypted_password = encrypt(password)
      end
    end
  end
end