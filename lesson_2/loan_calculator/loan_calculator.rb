def prompt(msg)
  puts "=> #{msg}"
end

def calculate(amount, apr, years)
  mpr = apr / 12 / 100
  months = (years * 12).round(0)

  payment = amount * (mpr / (1 - (1 + mpr)**(-months)))
  payment.round(2)
end

def valid_number?(num)
  Float(num)&.> 0
rescue
  false
end

def format_input(input)
  input.gsub(/\$|,|%/, '')
end

def collect_info(msg)
  input = ''
  loop do
    prompt(msg)
    input = format_input(gets.chomp)
    if valid_number?(input)
      break
    else
      prompt("Must enter a valid positive number. #{msg}")
    end
  end
  input.to_f
end

prompt('Welcome to the Loan Calculator')
continue = true

while continue
  amount = collect_info('Please enter the loan amount')
  apr = collect_info('Please enter the annual percentage rate (APR)')
  years = collect_info('Please enter loan duration in years')

  result = calculate(amount, apr, years)

  prompt("The monthly payment for this loan is #{result}")

  prompt('Would you like to do another calculation? (Y to continue)')
  continue = gets.chomp.downcase.start_with?('y')
end
prompt('Thanks you for using the Loan Calculator!')
