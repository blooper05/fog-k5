module Fog
  module K5
    module Shared
      K5_AUTH_BASE_URL = ''.freeze

      def refresh_auth_token_if_expired
        refresh_auth_token if auth_token_expired?
      end

      private

      def auth_token_expired?
        !Fog.credentials[:k5_auth_token_expires_at] ||
          Fog.credentials[:k5_auth_token_expires_at] - 300 < Fog::Time.now
      end

      def refresh_auth_token
        connection = Excon.new(K5_AUTH_BASE_URL)
        response   = connection.post(
          path:       'v3/auth/tokens',
          idempotent: true,
          expects:    201,
          body:       auth_request_body,
        )
        Fog.credentials[:k5_auth_token] = response.headers['X-Subject-Token']
        Fog.credentials[:k5_auth_token_expires_at] = Fog::Time.parse(
          Fog::JSON.decode(response.body)['token']['expires_at'],
        )
      end

      def auth_request_body
        Fog::JSON.encode(
          auth: {
            identity: {
              methods: %w[password],
              password: {
                user: {
                  domain: {
                    name: Fog.credentials[:k5_domain_name],
                  },
                  name: Fog.credentials[:k5_user_name],
                  password: Fog.credentials[:k5_user_password],
                },
              },
            },
            scope: {
              project: {
                id: Fog.credentials[:k5_project_id],
              },
            },
          },
        )
      end
    end
  end
end
