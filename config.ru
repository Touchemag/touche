use Rack::Static,
  :urls => %w(/css /img),
  :root => 'public'

def file_name(env)
  case env['REQUEST_PATH']
  when '/'
    '/index.html'
  when /\A\/\w+.html\Z/i
    env['REQUEST_PATH']
  else
    '/404.html'
  end
end

run lambda { |env|
  [
    200,
    {
      'Content-Type'  => 'text/html',
      'Cache-Control' => 'public, max-age=86400'
    },
    File.open(['public', file_name(env)].join(''), File::RDONLY)
  ]
}
