module EncryptedPasswd

  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_encrypted_passwd
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    attr_reader :password

    def self.included(base)
      require 'bcrypt'
      base.send :include, ::BCrypt
    end

    def password=(unencrypted_passwd)
      if unencrypted_passwd.nil?
        self.encrypted_passwd = nil
      else !unencrypted_passwd.empty?
        @password = unencrypted_passwd
        self.encrypted_passwd = BCrypt::Password.create(unencrypted_passwd, cost: nil)
      end
    end

    def authenticate(unencrypted_password)
      BCrypt::Password.new(encrypted_passwd) == unencrypted_password
    end
  end

end
