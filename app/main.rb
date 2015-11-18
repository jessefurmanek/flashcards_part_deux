require_relative 'runner.rb'

Runner.show_actions
input = Runner.get_and_valididate_input
Runner.execute_action(input)
