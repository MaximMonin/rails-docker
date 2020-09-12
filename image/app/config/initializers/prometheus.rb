unless Rails.env == "test"
  require 'prometheus_exporter/middleware'

  # This reports stats per request like HTTP status and timings
  Rails.application.middleware.unshift PrometheusExporter::Middleware
  PrometheusExporter::Client.new(custom_labels: { hostname: ENV.fetch("VIRTUAL_HOST", "rails") })
end

require 'prometheus_exporter/client'

class Prometheus
 include Singleton

  def client
    @client ||= PrometheusExporter::Client.default
  end

  def self.counters(*args)
    instance.counters(*args)
  end

  def self.histograms(*args)
    instance.histograms(*args)
  end

  def counters
    @counters ||= Hash.new do |hash, key|
      hash[key] = client.register(:counter, key, "count of #{key}")
    end
  end

  def histograms
    @histograms ||= Hash.new do |hash, key|
      hash[key] = client.register(:histogram, key, "histogram of #{key}")
    end
  end
end
