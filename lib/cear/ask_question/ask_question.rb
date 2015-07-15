class AskQuestion
	def initialize(__question, __default = nil)
		@question = __question
		@default  = __default
	end

	def ask
		line = nil
		while line == nil
			print "#{@question} #{@default ? "[#{@default}] " : ""}"
			STDOUT.flush
			line = STDIN.gets.chomp
			if line.empty?
				if @default
					return @default
				else
					line = nil
				end
			end
		end
		return line.downcase
	end
end
