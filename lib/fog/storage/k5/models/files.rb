module Fog
  module Storage
    class K5
      class Files < Fog::Collection
        model Fog::Storage::K5::File

        attribute :directory

        def new(attributes = {})
          requires :directory
          super({ directory: directory }.merge(attributes))
        end
      end
    end
  end
end
