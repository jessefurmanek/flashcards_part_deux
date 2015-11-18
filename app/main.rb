require_relative 'runner.rb'

Runner.bootstrap
Runner.show_actions
input = Runner.get_and_valididate_input
Runner.execute_action(input)
