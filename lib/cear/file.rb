#encoding: utf-8

##
## file.rb
## Gaetan JUVIN 15/07/2015
##

module Cear
	class File
		def initialize(__app_name, options = {})
			@app_name = __app_name
			@options  = options
		end

		def self.run(__app_name, options = {})
			Cear::File.new(__app_name, options).run
		end

		def run
			generate_file(@app_name)
		end

		def add_gems(condition, gems)
			condition ? gems.map {|g| "gem '#{g}'"}.join("\n") : ""
		end

		def template_exists?(file, path = '../../')
			::File.exists?(::File.expand_path("#{path}template/#{file}", __FILE__))
		end

		def file_generator(file, path = '../../')
			eval('"' + ::File.open(::File.expand_path("#{path}template/#{file}", __FILE__)).read + '"', binding, __FILE__, __LINE__)
		end

		def generate_file(filename, options = {})
			@filename = filename
			options   = {header: true}.merge(@options).merge(options)

			if ::File.exists?(@filename) == false or AskQuestion.new("Replace file #{@filename}?", "n/Y").ask != 'n'
				puts "Generate #{filename}".green
				::File.open(@filename, 'w') do |file|
					if options[:header]
						if template_exists?('header', '~/')
		 					file.write(file_generator('header', '~/') + "\n")
						else
		 					file.write(file_generator('header') + "\n")
			 			end
		 			end
					if template_exists?(@filename)
	 					file.write(file_generator(@filename))
		 			else
		 				file.write("# require ::File.expand_path('../config/environment',  __FILE__)\n")
		 			end
				end
			end
		end
	end
end