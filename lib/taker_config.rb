class TakerConfig
	require 'yamler'

	def initialize file
		config = YAML.load_file(file)
	end
end