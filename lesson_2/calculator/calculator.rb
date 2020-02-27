require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')
LANG = 'en'

def display_message(key, options = {})
  MESSAGES.dig(LANG, key) % options
end

def prompt(msg)
  puts "=> #{msg}"
end

def valid_number?(num)
  Float(num)
rescue
  false
end

def operation_to_message(op)
  msg =
    case op
    when '1'
      'Adding'
    when '2'
      'Subtracting'
    when '3'
      'Multiplying'
    when '4'
      'Dividing'
    end
  msg
end

def number_prompt_loop
  number = ''
  loop do
    number = gets.chomp
    if valid_number?(number)
      break
    else
      prompt display_message('invalid_number')
    end
  end
  number
end

def name_prompt_loop
  name = ''
  loop do
    name = gets.chomp
    name.empty? ? prompt(display_message('invalid_name')) : break
  end
  name
end

def operator_prompt_loop
  operator = ''
  loop do
    operator = gets.chomp
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt display_message('invalid_operator')
    end
  end
  operator
end

prompt display_message('welcome')
name = name_prompt_loop

prompt display_message('greeting', name: name)

loop do
  prompt display_message('first_number')
  number1 = number_prompt_loop

  prompt display_message('second_number')
  number2 = number_prompt_loop

  operator_msg = display_message('operator_msg')

  prompt(operator_msg)

  operator = operator_prompt_loop

  operation_msg = operation_to_message(operator)
  prompt display_message('operating_msg', operation: operation_msg)

  number1 = number1.to_i
  number2 = number2.to_i
  result =
    case operator
    when '1'
      number1 + number2
    when '2'
      number1 - number2
    when '3'
      number1 * number2
    when '4'
      number1 / number2.to_f
    end

  puts display_message('result', result: result)

  prompt display_message('another')
  another = gets.chomp
  break unless another.downcase.start_with?('y')
end
prompt display_message('thanks')
