# frozen_string_literal: true

module ScriptHelper
  def exec_script(script)
    skip_instruction = 0
    transfer_controller = nil
    transfer_action = nil

    script.each_with_index do |instruction, index|
      unless skip_instruction.zero?
        skip_instruction -= 1
        next
      end

      case
      when instruction.has_key?(:message)
        params = instruction[:message]
        puts params[:value].send((params[:color] || 'white').to_sym)
        if params[:jump]
          skip_instruction += params[:jump]
        end

      when instruction.has_key?(:prompt)
        params = instruction[:prompt]
        puts " - #{params[:message]} -"
        print ">>> "
        user_input params[:key], gets.chomp
        
      when instruction.has_key?(:options)
        options = instruction[:options][:values]
        range = 1..(options.length)
        loop do
          puts "Please Select 1 ~ #{options.length} :"
          options.each { |option| puts " - #{option}" }
          print ">>> "
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

      when instruction.has_key?(:post)
        params = instruction[:post]
        post_controller = Object.controller_const_get(params[:controller])
        post_action = params[:action].to_sym
        post_controller.new.send post_action, user_input_params

      when instruction.has_key?(:jump_to)
        skip_instruction = script.index({ label: instruction[:jump_to] }) - index

      when instruction.has_key?(:label)
        puts "Entering label: #{instruction[:lable]}".cyan if development?
      
      when instruction.has_key?(:transfer)
        params = instruction[:transfer]
        transfer_controller = Object.controller_const_get(params[:controller])
        transfer_action = params[:action].to_sym
        break

      when instruction.has_key?(:system)
        case instruction[:system]
        when 'clear' then system('clear')
        when 'exit'  then return
        end

      else
        puts "Missing instruction key: #{instruction.keys.first}"
      end
    end

    transfer_controller.new.send transfer_action
  end
end
