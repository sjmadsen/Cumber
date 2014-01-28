module Cumber

  ##
  # This class is the wrapper for the UIAKeyboard class.
  # The UIAKeyboard class allows users to interact with the keyboard object.

  class Keyboard

    ##
    # Appends the command to execute on the located keyboard and returns the response.
    #
    # ==== Parameters
    #
    # * +command+ - The additional step to execute on a UIAElement.
    #
    # ==== Examples
    #
    #   Cumber::Keyboard.search_and_execute_command("label()")

    def self.search_and_execute_command(command)

      step = search_description + '.' + command
      Cumber.execute_step(step)
    end

    ##
    # Returns the locator string to find the keyboard.

    def self.search_description
      %q[frontApp.keyboard()]
    end

    ##
    # Types the provided keys into the keyboard
    def self.type_string(value)

      response = search_and_execute_command("typeString('#{value}')")
      response['status'].should_not == 'error'
      response['status'] != 'error'
    end

  end
end