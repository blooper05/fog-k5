module Fog
  module Storage
    class K5
      class Real
        def get_object(container, object, _options = {})
          request(
            method:  :GET,
            path:    "#{container}/#{object}",
            expects: 200,
          )
        end
      end

      class Mock
        def get_object(_container, _object, _options = {})
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
