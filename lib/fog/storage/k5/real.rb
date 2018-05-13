module Fog
  module Storage
    class K5
      class Real
        include Utils

        K5_STORAGE_BASE_URL = ''.freeze

        def initialize(options = {})
          Fog.credentials[:k5_region]     = options[:k5_region]
          Fog.credentials[:k5_project_id] = options[:k5_project_id]

          @connection = Fog::Core::Connection.new(
            "#{K5_STORAGE_BASE_URL}AUTH_#{options[:k5_project_id]}?format=json",
          )
        end
      end
    end
  end
end
