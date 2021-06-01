if Rails.env.development?
  Rack::MiniProfiler.config.position = "bottom-right"
  Rack::MiniProfiler.config.start_hidden = true
  Rack::MiniProfiler.config.skip_paths = [/rails.*/]
end
