module Minimalist
  module Authentication
    def self.included( base )
      base.extend(ClassMethods)
      base.class_eval do
        include InstanceMethods
        
        attr_accessor :password
        before_save :encrypt_password
        
        named_scope :active, :conditions => {:active => true}
      end
    end
    
    module ClassMethods
      def authenticate(email, password)
        return if email.blank? || password.blank?
        if (user = active.first(:conditions => {:email => email, :crypted_password => password}))
          update_all("last_loggged_in_at='#{Time.now.to_s(:db)}'", "id=#{user.id}") # use update_all to avoid updated_on trigger
        end
        return user
      end
      
      #######
      private
      #######
      
      def secure_digest(*args)
        Digest::SHA1.hexdigest(args.flatten.join('--'))
      end

      def make_token
        secure_digest(Time.now, (1..10).map{ rand.to_s })
      end
    end
    
    module InstanceMethods
      
      private
      
      def encrypt_password
        return if password.blank?
        self.salt = self.class.make_token if new_record?
        self.crypted_password = encrypt(password)
      end
    end
  end
end