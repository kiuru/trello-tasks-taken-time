require 'trello'
require './trello_token.rb'
require './trello_conf.rb'

Trello.configure do |config|
  config.developer_public_key = TRELLO_DEVELOPER_PUBLIC_KEY
  config.member_token = TRELLO_MEMBER_TOKEN
end

member = Trello::Member.find(MEMBER_NAME)
puts "#{member.full_name}"
puts "Bio: #{member.bio}"

board = Trello::Board.find(BOARD_ID)

board.actions.each do |action|
	puts "id: #{action.id}, type: #{action.type}"
end