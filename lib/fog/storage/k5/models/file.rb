module Fog
  module Storage
    class K5
      class File < Fog::Model
        include Fog::K5::Shared

        identity :key

        attribute :body
        attribute :content_length, type: :integer
        attribute :content_type
        attribute :directory

        def destroy
          requires :directory, :key
          service.delete_object(directory.key, key)
          true
        end

        def public_url
          requires :directory, :key

          region      = service.k5_region
          project_id  = service.k5_project_id
          version     = K5_STORAGE_URL_VERSION
          url         = build_url(url_type: K5_STORAGE_URL_TYPE, region: region)
          container   = directory.key
          escaped_key = Excon::Utils.escape_uri(key)

          "#{url}/#{version}/AUTH_#{project_id}/#{container}/#{escaped_key}"
        end

        def save
          requires :body, :directory, :key

          service.put_object(directory.key, key, body)

          self.content_length = Fog::Storage.get_body_size(body)
          self.content_type ||= Fog::Storage.get_cotent_type(body)

          true
        end
      end
    end
  end
end
