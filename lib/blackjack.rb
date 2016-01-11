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
    puts "Sorry, you and the dealer both got #{dealer}. Ties go to the house in this casino!"
  elsif user > dealer || dealer > 21
    puts "You beat the dealer with a total of #{user}! He finished at #{dealer}."
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
    until dealer_total >= 17 || dealer_total >= user_total do
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

####################
####################    
##advanced blackjack
####################
####################

def runner3
  welcome
  deck = get_deck
  input = 'y'
  score = [0,0]

  until input != 'y' && input != 'Y' do

    user_cards = initial_round_with_decks(deck)

    dealer_shows = draw_card(deck, 0)
    dealer_cards = [dealer_shows, draw_card(deck, dealer_shows)]
    dealer_start(dealer_shows)

    until card_total(user_cards) > 21 do
      prev_cards = user_cards
      user_cards = hit_vs_dealer_with_deck?(deck, user_cards)

      if card_total(user_cards) == 0
        user_cards = prev_cards
        display_card_total_with_decks(user_cards)
        break
      end

      display_card_total_with_decks(user_cards)
    end

    user_total = card_total(user_cards)

    if user_total <= 21
      dealer_begins_playing_with_deck(dealer_cards)
      sleep(1.5)
      until card_total(dealer_cards) >= 17 || card_total(dealer_cards) >= user_total do
        new_dealer_card = draw_card(deck, card_total(dealer_cards))
        dealer_cards.push(new_dealer_card)
        display_dealer_hit(new_dealer_card)
        sleep(1.5)
        display_dealer_total(card_total(dealer_cards))
        sleep(1.5)
      end

      dealer_total = card_total(dealer_cards)
      end_vs_dealer_with_deck(user_total, dealer_total, score)
    else
      end_game_with_deck(user_total, score)
    end
    sleep(1.5)
    puts "There are #{deck.size} cards left in the deck."
    puts "Would you like to play again? (y/n)"
    input = get_user_input
  end
end



def get_deck
  [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,
   5,5,5,5,6,6,6,6,7,7,7,7,8,8,8,8,
   9,9,9,9,10,10,10,10,10,10,10,10,
   10,10,10,10,10,10,10,10]
end

#GOTTA DO ACES

def draw_card(deck, dealer_total = -1)
  if deck.size == 0
    deck.concat get_deck
  end
  index = rand(deck.size)
  card = deck[index]
  if card == 1
    card = handle_aces(dealer_total)
  end
  deck.delete_at(index)
  card
end

def handle_aces(dealer)
  score = 11
  input = 0
  if dealer == -1
    until input == '1' || input == '11' do
      puts "You drew an ace! Type in '1' to score 1 or '11' to score 11."
      input = get_user_input
    end
    score = input.to_i
  else
    if dealer + 11 > 21
      score = 1
    else
      score = 11
    end
  end

  score
end

def card_total(cards)
  sum = 0
  cards.each do |card|
    sum += card
  end

  sum
end

def initial_round_with_decks(deck)
  card1 = draw_card(deck)
  card2 = draw_card(deck)
  display_card_total_with_decks([card1, card2])
end

def display_card_total_with_decks(cards)
  sum = 0
  print "You have a:"
  cards.each do |card|
    sum += card
    print " #{card}"
  end
  print ".\nYour cards add up to #{sum}.\n"

  cards
end

def hit_vs_dealer_with_deck?(deck, cards)
  prompt_user
  input = get_user_input

  case input
    when 'h'
      cards.push(draw_card(deck))
    when 's'
      cards = [0]
    else
      invalid_command
      prompt_user
  end

  cards
end

def dealer_begins_playing_with_deck(cards)
  puts "The dealer shows his second card, #{cards[1]}, adding up to #{cards[0] + cards[1]}."
end

def end_vs_dealer_with_deck(user, dealer, score)
  if dealer == user
    score[1] += 1
    puts "Sorry, you and the dealer both got #{dealer}. Ties go to the house in this casino!"
  elsif user > dealer || dealer > 21
    score[0] += 1
    puts "You beat the dealer with a total of #{user}! He finished at #{dealer}."
  else
    score[1] += 1
    puts "Sorry, The dealer beat you #{dealer} to #{user}."
  end
  display_score(score)
end

def end_game_with_deck(number, score)
  # code #end_game here
  score[1] += 1
  puts "Sorry, you hit #{number}. Thanks for playing!"
  display_score(score)
end

def display_score(score)
    puts "You have a #{score[0]} - #{score[1]} record against the dealer."
end