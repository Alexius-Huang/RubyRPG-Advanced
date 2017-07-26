# frozen_string_literal: true

module ScriptHelper
  def exec_script(script, skip_to_instruction_label = nil)
    skip_instruction = 0
    transfer_controller = nil
    transfer_action = nil
    rerun_script = false

    script.each_with_index do |instruction, index|
      next if skip_to_instruction_label and not instruction.has_key?(:label) and not instruction[:label] == skip_to_instruction_label
      skip_to_instruction_label = nil

      unless skip_instruction.zero?
        skip_instruction -= 1
        next
      end

      case
      when instruction.has_key?(:message)
        params = instruction[:message]
        puts " :: #{params[:value].send((params[:color] || 'white').to_sym)}"
        skip_instruction += params[:jump] if params[:jump]

      when instruction.has_key?(:input)
        params = instruction[:input]
        case params[:type]
        when 'prompt'
          puts " - #{params[:message]} -".cyan
          print " >>> "
          user_input params[:key].to_sym, gets.chomp
        when 'range'
          loop do
            puts " - Please Input #{params[:start]} ~ #{params[:end]} -".cyan
            print " >>> "
            input = gets.chomp.to_i
            if (params[:start]..params[:end]).include? input
              user_input params[:key].to_sym, input
              break
            else
              puts " :: Wrong Selection! Please Input in Range #{params[:start]} ~ #{params[:end]}".red
            end
          end
        when 'text'
          user_input params[:key].to_sym, (params[:value] || gets.chomp)
        end

      when instruction.has_key?(:options)
        params = instruction[:options]
        options = params[:values]
        range = 1..(options.length)
        loop do
          puts " - #{params[:message]} -".cyan if params[:message]
          puts " - Please Select 1 ~ #{options.length} -"
          options.each_with_index { |option, index| puts " (#{index.next}) #{option}".yellow }
          print " >>> "
          selection = gets.chomp
          if not Regex.match_digits?(selection)
            puts "Wrong Selection! Please Select Again!".red
          elsif not range.include?(selection.to_i)
            puts "Wrong Selection! Please Input in Range #{range.first} ~ #{range.last}!".red
          else
            skip_instruction = selection.to_i.pred
            break
          end
        end

      when (instruction.has_key?(:if) or instruction.has_key?(:elsif))
        params = instruction.has_key?(:if) ? instruction[:if] : instruction[:elsif]
        jump_label = params[:condition] ? params[:jump] : params[:else_jump]
        next if jump_label.nil?
        skip_instruction = script.index({ label: jump_label }) - index

      when instruction.has_key?(:post)
        params = instruction[:post]
        post_controller = Object.controller_const_get(params[:controller])
        post_action = params[:action].to_sym
        post_controller.new.send post_action, user_input_params

      when instruction.has_key?(:send)
        params = instruction[:send]
        eval "#{params[:receiver]}.send(:#{params[:method]})"

      when instruction.has_key?(:jump_to)
        skip_instruction = script.index({ label: instruction[:jump_to] }) - index

      when instruction.has_key?(:label)
        # puts "Entering label: #{instruction[:label]}".cyan if development?
      
      when instruction.has_key?(:transfer)
        params = instruction[:transfer]
        transfer_controller = Object.controller_const_get(params[:controller])
        transfer_action = params[:action].to_sym
        ApplicationController.set_transfer_label params[:skip_to] if params.has_key?(:skip_to)
        ApplicationController.set_params params[:params] if params.has_key?(:params)
        break

      when instruction.has_key?(:system)
        case
        when instruction[:system].start_with?('sleep') then system("sleep #{instruction[:system].split(' ')[1]}")
        end

        case instruction[:system]
        when 'clear'    then system('clear')
        when 'new_line' then puts ''
        when 'exit'     then return
        when 'rerun_controller'
          transfer_controller = Object.const_get "#{current_class.to_camelcase}Controller"
          transfer_action = current_method
          break
        when 'rerun_script'
          rerun_script = true
          break
        end

      else
        puts "Missing instruction key: #{instruction.keys.first}"
      end
    end

    case
    when rerun_script
      exec_script script, skip_to_instruction_label
    when (not transfer_controller.nil? and not transfer_action.nil?)
      transfer_controller.new.send transfer_action
    end
  end
end
