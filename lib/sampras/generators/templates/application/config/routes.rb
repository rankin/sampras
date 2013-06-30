# Check out https://github.com/joshbuddy/http_router for more information on HttpRouter
base = File.expand_path(File.dirname(__FILE__))

HttpRouter.new do
  add('/').static("#{base}/index.html")

  # serve static assets
  add('/stylesheets').static("#{base}/public/stylesheets")
  add('/javascripts').static("#{base}/public/javascripts")
end
