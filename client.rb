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

actions = Hash.new

board.actions.reverse_each do |action|
	if action.type == "updateCard" && action.data["listAfter"].present? && (action.data["listBefore"]["name"] == "Doing" || action.data["listAfter"]["name"] == "Doing")
		card_id = action.data["card"]["id"]
		if actions[card_id].nil?
			actions[card_id] = Array.new
		end
		actions[card_id] << action.date
	end
end

puts actions.inspect