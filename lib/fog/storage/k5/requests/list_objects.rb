module Fog
  module Storage
    class K5
      class Real
        def list_objects(container, _options = {})
          request(
            method: :GET,
            path:   container,
          )
        end
      end

      class Mock
        def list_objects(_container, _options = {})
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
