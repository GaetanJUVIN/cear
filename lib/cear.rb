#!/usr/bin/env ruby
#encoding: utf-8

##
## cear.rb
## Gaetan JUVIN 15/07/2015
##

require 'active_record'
require 'colorize'
require 'active_support/inflector'
require 'pty'

require 'cear/version'
require 'cear/cear_config'
require 'cear/file'
require 'cear/project'
require 'cear/ask_question/ask_question'

module Cear
	def self.run(__app_name = nil)
		if __app_name != nil and __app_name.end_with?('.rb')
			Cear::File.run(__app_name)
		else
			Cear::Project.run(__app_name)
		end
	end

end
