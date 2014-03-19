module Cumber

  ##
  # This class is the wrapper for the UIATextField class.
  # The UIATextField class allows users to interact with text field objects. UIATextField is a subclass of UIAElement
  class TextField < Element

    ##
    # Sets the value of the text field to the given string. Note the will clear out any existing text in the text field.
    #
    # ==== Examples
    #
    #   sample_text_box = Cumber::TextField.new(:label => "testTextBox") <br>
    #   sample_text_box.set_value('Hello')

    def set_value(text)
      response = search_and_execute_command("setValue('#{text}')")
      ResponseHelper.process_operation_response(response)
    end
  end
end