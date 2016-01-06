def welcome
  # code #welcome here
  puts "Welcome to the Blackjack Table"
end

def deal_card
  # code #deal_card here
  rand(1..11)
end

def display_card_total(number)
  # code #display_card_total here
  puts "Your cards add up to #{number}"
end

def prompt_user
  # code #prompt_user here
  puts "Type 'h' to hit or 's' to stay"
end

def get_user_input
  # code #get_user_input here
  gets.chomp
end

def end_game(number)
  # code #end_game here
  puts "Sorry, you hit #{number}. Thanks for playing!"
end

def initial_round
  # code #initial_round here
  sum = deal_card + deal_card
  display_card_total(sum)
  sum
end

def hit?(current_number)
  prompt_user
  total = current_number
  input = get_user_input

  case input
    when 'h'
      total += deal_card
    when 's'
      #do nothing
    else
      invalid_command
      prompt_user
  end
  
  total
end


def hit_vs_dealer?(current_number)
  prompt_user
  total = current_number
  input = get_user_input

  case input
    when 'h'
      total += deal_card
    when 's'
      total = 0
    else
      invalid_command
      prompt_user
  end
  
  total
end

def invalid_command
  # code invalid_command here
  puts "Please enter a valid command"
end

def dealer_start(number)
  puts "The dealer has a(n) #{number} showing."
end

def dealer_begins_playing(number)
  puts "The dealer shows his second card, adding up to #{number}."
end

def display_dealer_total(number)
  puts "Dealer's cards add up to #{number}"
end

def display_dealer_hit(number)
  puts "Dealer hits and draws a(n) #{number}"
end

def end_vs_dealer(user, dealer)
  if dealer == user
    puts "Sorry, you and the dealer both got #{dealer}. Ties go to the house!"
  elsif dealer > 21
    puts "You beat the dealer with a total of #{user}! He busted at #{dealer}."
  else
    puts "Sorry, The dealer beat you #{dealer} to #{user}."
  end
end

#####################################################
# get every test to pass before coding runner below #
#####################################################

def runner
  # code runner here
  welcome
  total = initial_round
  until total > 21 do
    total = hit?(total)
    display_card_total(total)
  end
  end_game(total)
end

def runner2
  welcome
  user_total = initial_round
  
  dealer_shows = deal_card
  dealer_total = dealer_shows + deal_card
  dealer_start(dealer_shows)

  until user_total > 21 do
    prev_total = user_total
    user_total = hit_vs_dealer?(user_total)

    if user_total == 0
      user_total = prev_total
      display_card_total(user_total)
      break
    end

    display_card_total(user_total)
  end

  if user_total <= 21
    dealer_begins_playing(dealer_total)
    sleep(1.5)
    until dealer_total > 21 || dealer_total >= user_total do
      dealer_hit = deal_card
      dealer_total += dealer_hit
      display_dealer_hit(dealer_hit)
      sleep(1.5)
      display_dealer_total(dealer_total)
      sleep(1.5)
    end

    end_vs_dealer(user_total, dealer_total)
  else
    end_game(user_total)
  end
end
    
