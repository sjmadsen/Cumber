module Cumber

  ##
  # This class is the wrapper for the UIAKeyboard class.
  # The UIAKeyboard class allows users to interact with the keyboard object. UIAKeyboard is a subclass of UIAElement

  class Keyboard < Element

    ##
    # Returns the locator string to find the keyboard.

    def search_description
      %q[frontApp.keyboard()]
    end

    ##
    # Types the provided keys into the keyboard
    def type_string(value)

      text = value.gsub("'","\\\\\\\\'")
      response = search_and_execute_command("typeString('#{text}')")
      ResponseHelper.process_operation_response(response)
    end

  end
end