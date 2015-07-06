#!/usr/bin/env ruby

require 'fileutils'

Dir["#{Dir.pwd}/*"].each do |file|
  dest = file.split('/').last.split('.').first.downcase.tr('\'', '').gsub(/\W+/, '-')
  begin
	FileUtils.mv(file, dest + '.' + file.split('/').last.split('.').last)
  rescue ArgumentError => e
	puts e.message
  end 
end
