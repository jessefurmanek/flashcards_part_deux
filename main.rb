require_relative 'runner.rb'

Runner.bootstrap
Runner.show_actions
input = Runner.get_input
Runner.execute_action(input)
