module Fog
  module Storage
    class K5
      class Real
        def list_containers(_options = {})
          request(
            headers: {
              'X-Auth-Token' => '',
            },
            method: :GET,
          )
        end
      end

      class Mock
        def list_containers(_options = {})
          Fog::Mock.not_implemented
        end
      end
    end
  end
end
