module Fog
  module Storage
    class K5
      module Utils
        def request(params)
          escaped_params = escape(add_auth_header(params))
          parse(@connection.request(escaped_params))
        end

        private

        def add_auth_header(params)
          params.merge(headers: { 'X-Auth-Token' => @k5_auth_token })
        end

        def escape(params)
          middlewares = Excon.defaults[:middlewares] +
                        [Excon::Middleware::EscapePath]
          params.merge(middlewares: middlewares)
        end

        def parse(response)
          return response if response.body.empty?
          return response unless json?(response)

          response.body = Fog::JSON.decode(response.body)
          response
        end

        def json?(response)
          response.headers['Content-Type'].include?('application/json')
        end
      end
    end
  end
end
