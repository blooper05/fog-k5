# frozen_string_literal: true

module Fog
  module Storage
    class K5
      class Directory < Fog::Model
        identity :key

        def files
          @files ||= Fog::Storage::K5::Files.new(
            directory: self,
            service:   service,
          )
        end
      end
    end
  end
end
