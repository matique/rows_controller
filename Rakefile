require File.expand_path('../test/dummy/config/application', __FILE__)

Rails.application.load_tasks
Bundler::GemHelper.install_tasks

desc "Clean automatically generated files"
task :clean do
  FileUtils.rm_rf "pkg"
end

desc "Check syntax"
task :syntax do
  Dir["**/*.rb"].each do |file|
    print "#{file}: "
    system("ruby -c #{file}")
  end
end
