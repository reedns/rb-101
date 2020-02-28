VALID_CHOICES = %w(rock paper scissors)

def prompt(msg)
  puts "=> #{msg}"
end

def line_break
  puts "\n"
end

def valid_choices_string
  VALID_CHOICES.join(', ')
end

def wins?(is_winner, is_loser)
  winning_combos = {
    rock: 'scissors',
    paper: 'rock',
    scissors: 'paper'
  }
  winning_combos[is_winner.to_sym] == is_loser
end

def results(player, computer)
  winning_msgs = {
    rock: 'rock breaks scissors',
    paper: 'paper covers rock',
    scissors: 'scissors cut paper'
  }
  if wins?(player, computer)
    "You win, #{winning_msgs[player.to_sym]} :)"
  elsif wins?(computer, player)
    "You lose, #{winning_msgs[computer.to_sym]} :("
  else
    "It's a tie :\\"
  end
end

loop do
  player_choice = ''
  prompt("Choose one: #{valid_choices_string}")
  loop do
    player_choice = gets.chomp.downcase
    if VALID_CHOICES.include?(player_choice)
      break
    else
      prompt("You can only choose: #{valid_choices_string}")
    end
  end

  computer_choice = VALID_CHOICES.sample

  line_break
  prompt("You chose: #{player_choice}. The computer chose: #{computer_choice}")

  results = results(player_choice, computer_choice)
  prompt(results)
  line_break

  prompt('Do you want to play again? (Y to continue)')

  play_again = gets.chomp.downcase.start_with?('y')
  if play_again
    system 'clear'
  else
    break
  end
end
