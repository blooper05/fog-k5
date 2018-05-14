module Fog
  module Storage
    class K5
      class Real
        include Utils
        include Fog::K5::Shared

        K5_STORAGE_URL_TYPE    = 'objectstorage'.freeze
        K5_STORAGE_URL_VERSION = 'v1'.freeze

        def initialize(options = {})
          Fog.credentials[:k5_region]        = options[:k5_region]
          Fog.credentials[:k5_project_id]    = options[:k5_project_id]
          Fog.credentials[:k5_domain_name]   = options[:k5_domain_name]
          Fog.credentials[:k5_user_name]     = options[:k5_user_name]
          Fog.credentials[:k5_user_password] = options[:k5_user_password]

          refresh_auth_token_if_expired

          url = build_url(url_type: K5_STORAGE_URL_TYPE)
          @connection = Fog::Core::Connection.new(url, false, params)
        end

        private

        def params
          token      = Fog.credentials[:k5_auth_token]
          project_id = Fog.credentials[:k5_project_id]
          version    = K5_STORAGE_URL_VERSION
          {
            headers:     { 'X-Auth-Token' => token },
            path_prefix: "#{version}/AUTH_#{project_id}",
            query:       { format: :json },
          }
        end
      end
    end
  end
end
