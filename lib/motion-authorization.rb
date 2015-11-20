unless defined?(Motion::Project::Config)
  raise 'This gem is intended to be used in a RubyMotion project.'
end

Motion::Project::App.setup do |app|
  app.files += Dir.glob(File.join(File.dirname(__FILE__), 'motion', '**', '*.rb'))
end
