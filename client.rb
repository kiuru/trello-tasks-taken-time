require 'trello'
require './trello_token.rb'

member_name = "kiuru" # whom task you would like to see

Trello.configure do |config|
  config.developer_public_key = TRELLO_DEVELOPER_PUBLIC_KEY
  config.member_token = TRELLO_MEMBER_TOKEN
end

member = Trello::Member.find(member_name)
puts "#{member.full_name}"
puts "Bio: #{member.bio}"

member.boards.each do |board|
	puts board.name
end
