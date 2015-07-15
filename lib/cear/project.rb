#encoding: utf-8

##
## project.rb
## Gaetan JUVIN 15/07/2015
##

# get name
# ask db
# ask redis
# create main directory
# create Gemfile
# create other directory [app, config, db, lib, log, tmp]
# add 2 line at the top of name.rb


# What is the project name ?
# Do you want to include redis ?
# Do you want to include pg ?

module Cear
	class Project
		def initialize(__app_name = nil)
			@app_name = __app_name
		end

		def run_bundle
			puts "Run bundle install...".yellow
			begin
			  PTY.spawn("bundle") do |stdout, stdin, pid|
			    begin
			      # Do stuff with the output here. Just printing to show it works
			      stdout.each { |line| print line;STDOUT.flush }
			    rescue Errno::EIO
			      puts "Errno:EIO error, but this probably just means " +
			            "that the process has finished giving output"
			    end
			  end
			rescue PTY::ChildExited
			  puts "The child process exited!"
			end
			puts "Run bundle install OK".green
		end

		def self.run(__app_name)
			Cear::Project.new(__app_name).run
		end

		def run
			if @app_name == nil
				@app_name = AskQuestion.new("What is the project name?").ask
			end
			@include_pg      = AskQuestion.new("Do you want to include pg?", "N/y").ask == 'y'
			@include_redis   = AskQuestion.new("Do you want to include redis?", "N/y").ask == 'y'
			@include_rake    = AskQuestion.new("Do you want to include rake?", "N/y").ask == 'y'
			@include_advance = AskQuestion.new("Do you want advance mode ? (included subdirectories 'app', 'log', 'tmp')", "N/y").ask == 'y'
			@app_name = @app_name.underscore.gsub(' ', '_')

			Dir.mkdir(@app_name) unless ::File.exists?(@app_name)
			Dir.chdir(@app_name) do |dir|
				Cear::File.run('Gemfile', header: false)
				Cear::File.run(@app_name + '.rb')
				Cear::File.run('console.rb')

				directories = ['config', 'lib']
				directories << 'db' if @include_pg
				directories += ['app', 'log', 'tmp'] if @include_advance
				puts "Create directories | #{directories.join(' - ')}".light_green

				directories.each do |subdirectory|
					Dir.mkdir(subdirectory) unless ::File.exists?(subdirectory)
				end

				Dir.chdir('config') do |dir|
					Cear::File.run('environment.rb')
					Cear::File.run('application.rb')
					Cear::File.run('database.yaml', header: false) if @include_pg
				end

				if @include_rake
					Cear::File.run('Rakefile')
				end
				run_bundle
			end
		end
	end
end