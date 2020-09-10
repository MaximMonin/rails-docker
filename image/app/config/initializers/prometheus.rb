unless Rails.env == "test"
  require 'prometheus_exporter/middleware'
  
  # This reports stats per request like HTTP status and timings
  Rails.application.middleware.unshift PrometheusExporter::Middleware

  PrometheusExporter::Client.new(custom_labels: { hostname: ENV.fetch("VIRTUAL_HOST", "rails") })
end