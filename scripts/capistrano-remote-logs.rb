def role(a1, a2)
end

def lock(a1)
end

def set(a1, a2)
 if a1 == :deploy_to
   @data[:path] = a2
 end
end

def namespace(a1)
end

@data = {}

def server(a1, a2)
  @data[:host] = a1
  @data[:user] = a2[:user]   
end

begin
  require "#{Dir.pwd}/config/deploy/production.rb"
  require "#{Dir.pwd}/config/deploy.rb"
  #puts @data.inspect
  cmd = "ssh #{@data[:user]}@#{@data[:host]} \"tail -f #{@data[:path]}/current/log/production.log #{ARGV.join(' ')}\""
  puts cmd
  exec(cmd)
rescue LoadError
  puts "files not found"
end
