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

        def public_url
          requires :directory, :key

          project_id = Fog.credentials[:k5_project_id]
          version    = K5_STORAGE_URL_VERSION
          url        = build_url(url_type: K5_STORAGE_URL_TYPE)
          container  = directory.key

          "#{url}/#{version}/AUTH_#{project_id}/#{container}/#{key}"
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
