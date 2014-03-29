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

current_time = Time.new

actions.each do |key,value|

	tmp_datetime = nil
	total = 0

	value.each_with_index do |datetime,index|
		if tmp_datetime.present?
			total += ((datetime - tmp_datetime) / 1.day)
		end
		tmp_datetime = datetime
		@i = index
	end

	if (@i % 2) == 0
		total += ((current_time - tmp_datetime) / 1.day)
	end

	puts "id: #{key} - Total working time: #{total}"
	
end