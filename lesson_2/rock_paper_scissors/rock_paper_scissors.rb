require 'yaml'
VALID_CHOICES = {
  'r' => 'rock',
  'p' => 'paper',
  'sc' => 'scissors',
  'l' => 'lizard',
  'sp' => 'spock'
}
MESSAGES = YAML.load_file('rock_paper_scissors.yml')

def prompt(msg)
  puts "=> #{msg}"
end

def line_break
  puts "\n"
end

def display_msg(key, options = {})
  prompt MESSAGES[key] % options
end

def valid_choices_string
  formatted_choices =
    VALID_CHOICES.map do |abbrev, choice|
      "#{choice} (#{abbrev})"
    end
  formatted_choices.join(', ')
end

def valid_choice?(choice)
  VALID_CHOICES.values.include?(choice)
end

def wins?(is_winner, is_loser)
  winning_combos = {
    rock: %w(scissors lizard),
    paper: %w(rock spock),
    scissors: %w(paper lizard),
    lizard: %w(paper spock),
    spock: %w(rock scissors)
  }
  winning_combos[is_winner.to_sym].include?(is_loser)
end

def results_msg(winner, player_choice, computer_choice)
  if winner[:type] == 'player'
    msg = MESSAGES.dig(player_choice, computer_choice)
    prompt(msg)
    display_msg('win')
  elsif winner[:type] == 'computer'
    msg = MESSAGES.dig(computer_choice, player_choice)
    prompt(msg)
    display_msg('lose')
  else
    display_msg('tie')
  end
end

def convert_choice(choice)
  choice.size <= 2 ? VALID_CHOICES[choice] : choice
end

def determine_winner(player, computer)
  if wins?(player[:choice], computer[:choice])
    player
  elsif wins?(computer[:choice], player[:choice])
    computer
  else
    {}
  end
end

def increment_score(winner)
  return if winner.empty?
  winner[:score] += 1
end

def grand_winner_msg(player, computer)
  if player[:score] > computer[:score]
    display_msg('player_winner')
  else
    display_msg('computer_winner')
  end
end

display_msg('welcome')
display_msg('objective')
line_break

player = { type: 'player', score: 0, choice: nil }
computer = { type: 'computer', score: 0, choice: nil }

loop do
  display_msg('score', { player: player[:score], computer: computer[:score] })
  line_break
  display_msg('choose', { valid_choices: valid_choices_string })

  loop do
    player[:choice] = convert_choice(gets.chomp.downcase)
    if valid_choice?(player[:choice])
      break
    else
      display_msg('invalid_choice', { valid_choices: valid_choices_string })
    end
  end

  computer[:choice] = VALID_CHOICES.values.sample
  system 'clear'
  display_msg(
    'choices',
    player_choice: player[:choice],
    computer_choice: computer[:choice]
  )
  line_break

  winner = determine_winner(player, computer)
  increment_score(winner)
  results_msg(winner, player[:choice], computer[:choice])

  line_break

  if player[:score] == 5 || computer[:score] == 5
    display_msg(
      'final_score',
      player: player[:score],
      computer: computer[:score]
    )
    grand_winner = grand_winner_msg(player, computer)
    prompt(grand_winner)
    display_msg('play_again')
    play_again = gets.chomp.downcase.start_with?('y')
    play_again ? system('clear') : break
  end
end
