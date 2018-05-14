module Fog
  module Storage
    class K5
      class File < Fog::Model
        identity :key

        attribute :body
        attribute :content_length, type: :integer
        attribute :content_type
        attribute :directory

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
