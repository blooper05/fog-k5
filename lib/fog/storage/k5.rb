# frozen_string_literal: true

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

      K5_STORAGE_URL_TYPE    = 'objectstorage'
      K5_STORAGE_URL_VERSION = 'v1'

      model_path 'fog/storage/k5/models'

      collection :directories
      model :directory

      collection :files
      model :file

      request_path 'fog/storage/k5/requests'
      request :delete_object
      request :get_object
      request :list_containers
      request :list_objects
      request :put_object
    end
  end
end
