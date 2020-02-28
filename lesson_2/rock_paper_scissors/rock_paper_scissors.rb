VALID_CHOICES = %w(rock paper scissors)
PAPER_ROCK = 'Paper covers rock'
ROCK_SCISSORS = 'Rock breaks scissors'
SCISSORS_PAPER = 'Scissors cut paper'

def prompt(msg)
  puts "=> #{msg}"
end

def valid_choices_string
  VALID_CHOICES.join(', ')
end

def wins?(is_winner, is_loser)
  (is_winner == 'rock' && is_loser == 'scissors') ||
    (is_winner == 'paper' && is_loser == 'rock') ||
    (is_winner == 'scissors' && is_loser == 'paper')
end

def results(player, computer)
  results_msg_hash = {
    rock: { paper: PAPER_ROCK, scissors: ROCK_SCISSORS },
    paper: { rock: PAPER_ROCK, scissors: SCISSORS_PAPER },
    scissors: { rock: ROCK_SCISSORS, paper: SCISSORS_PAPER }
  }
  results_msg = results_msg_hash.dig(player.to_sym, computer.to_sym)
  if wins?(player, computer)
    "#{results_msg}, you win :)"
  elsif wins?(computer, player)
    "#{results_msg}, you lose :("
  else
    "It's a tie :\\"
  end
end

loop do
  player_choice = ''
  loop do
    prompt("Choose one: #{valid_choices_string}")
    player_choice = gets.chomp
    if VALID_CHOICES.include?(player_choice.downcase)
      break
    else
      prompt("Must choose: #{valid_choices_string}")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{player_choice}. The computer chose: #{computer_choice}")

  results = results(player_choice, computer_choice)
  prompt(results)

  prompt('Do you want to play again? (Y to continue)')
  play_again = gets.chomp.downcase.start_with?('y')
  break unless play_again
end
