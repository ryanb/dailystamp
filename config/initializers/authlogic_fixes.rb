# See https://github.com/mreinsch/authlogic_openid/commit/9b802c347f5addebcbce945af3b5f80b3ee7b214
# and http://stackoverflow.com/questions/2092694/authlogic-openid-error-uninitialized-constant-openidauthenticationinvalidopeni
module AuthlogicOpenid
  module ActsAsAuthentic
    module Methods
      def openid_identifier=(value)
        write_attribute(:openid_identifier, value.blank? ? nil : OpenID.normalize_url(value))
        reset_persistence_token if openid_identifier_changed?
      rescue OpenID::DiscoveryFailure => e
        @openid_error = e.message
      end
    end
  end
end

module AuthlogicOpenid
  module Session
    module Methods
      def openid_identifier=(value)
        @openid_identifier = value.blank? ? nil : OpenID.normalize_url(value)
        @openid_error = nil
      rescue OpenID::DiscoveryFailure => e
        @openid_identifier = nil
        @openid_error = e.message
      end
    end
  end
end
