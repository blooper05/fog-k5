module Fog
  module Storage
    class K5 < Fog::Service
      autoload :Mock,  File.expand_path('k5/mock',  __dir__)
      autoload :Real,  File.expand_path('k5/real',  __dir__)
      autoload :Utils, File.expand_path('k5/utils', __dir__)

      requires :k5_region,
               :k5_project_id,
               :k5_domain_name,
               :k5_user_name,
               :k5_user_password

      recognizes :k5_auth_token,
                 :k5_auth_token_expires_at

      request_path 'fog/storage/k5/requests'
      request :list_containers
    end
  end
end
