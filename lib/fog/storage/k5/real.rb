module Fog
  module Storage
    class K5
      class Real
        include Utils
        include Fog::K5::Shared

        K5_STORAGE_BASE_URL = ''.freeze

        def initialize(options = {})
          Fog.credentials[:k5_region]        = options[:k5_region]
          Fog.credentials[:k5_project_id]    = options[:k5_project_id]
          Fog.credentials[:k5_domain_name]   = options[:k5_domain_name]
          Fog.credentials[:k5_user_name]     = options[:k5_user_name]
          Fog.credentials[:k5_user_password] = options[:k5_user_password]

          refresh_auth_token_if_expired

          @connection = Fog::Core::Connection.new(
            "#{K5_STORAGE_BASE_URL}AUTH_#{options[:k5_project_id]}?format=json",
          )
        end
      end
    end
  end
end
