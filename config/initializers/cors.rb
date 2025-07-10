Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins "https://guileless-llama-116fdb.netlify.app"
    origins "http://localhost:4200"
    resource "*",
      headers: :any,
      methods: [ :get, :post, :patch, :put, :delete, :options ],
      expose: ['Authorization']
  end
end
