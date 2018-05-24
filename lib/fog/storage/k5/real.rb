module Fog
  module Storage
    class K5
      class Real
        include Utils
        include Fog::K5::Shared

        attr_reader :k5_region, :k5_project_id

        def initialize(options = {})
          refresh_credentials(options)

          url = build_url(url_type: K5_STORAGE_URL_TYPE)
          @connection = Fog::Core::Connection.new(url, false, params)
        end

        private

        def refresh_credentials(options)
          @k5_region        = options[:k5_region]
          @k5_project_id    = options[:k5_project_id]
          @k5_domain_name   = options[:k5_domain_name]
          @k5_user_name     = options[:k5_user_name]
          @k5_user_password = options[:k5_user_password]
        end

        def params
          {
            path_prefix: "#{K5_STORAGE_URL_VERSION}/AUTH_#{@k5_project_id}",
            query:       { format: :json },
          }
        end
      end
    end
  end
end
