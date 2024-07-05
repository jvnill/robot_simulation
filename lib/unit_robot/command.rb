Dir.glob(File.expand_path('..', __FILE__) + '/command/*') do |path|
  require_relative "command/#{File.basename(path, '.rb')}"
end

module UnitRobot::Command
end
