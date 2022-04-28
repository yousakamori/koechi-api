module RouteRecognizer
  module_function

  INITIAL_SEGMENT_REGEX = %r{^/([^/(:]+)}

  def top_level_path
    routes = Rails.application.routes.routes
    routes.collect { |r| match_initial_path(r.path.spec.to_s) }.compact.uniq
  end

  def match_initial_path(path)
    if match = INITIAL_SEGMENT_REGEX.match(path)
      match[1]
    end
  end
end
