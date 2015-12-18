#!/usr/bin/env ruby

require 'find'

def find_manifest
  Find.find(Dir.pwd) do |path|
    if path.end_with? 'AndroidManifest.xml' and !path.include? '/build/'
      return contents = File.read(path)
    end
  end

  return nil
end

@package = /package="([a-z.]+)"/.match(find_manifest)[1]
@device_id = (`adb devices`).split("\n")[1].split("\t")[0]
@file = 'Application.db'

def db_pull
  #`adb -s "#{@device_id}" shell "run-as #{@package} cp /data/data/#{@package}/databases/Application.db > /sdcard/#{@package}.db"`
  `adb -s "#{@device_id}" pull "/data/data/#{@package}/databases/#{@file}"`
end

def pref_pull
  `adb -s "#{@device_id}" shell "run-as #{@package} cp /data/data/#{@package}/shared_prefs > /sdcard/#{@package}.pref"`
  `adb -s "#{@device_id}" pull "/sdcard/#{@package}.pref"`
end

def ls
  `adb -s "#{@device_id}" shell "run-as #{@package} ls /data/data/#{@package}"`
end

def db_open
  `sqlitebrowser #{@file}`
end

if ARGV.length == 0 or ARGV[0] == '-h'
  puts 'use db-open or db-pull'
elsif ARGV.length == 1
  if ARGV[0] == 'db-open'
    db_pull
    db_open
  elsif ARGV[0] == 'db-pull'
    db_pull
  elsif ARGV[0] == 'ls'
    ls
  elsif ARGV[0] == 'pref-pull'
    pref_pull
  end
end
