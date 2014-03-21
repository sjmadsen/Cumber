module Cumber

  ##
  # This class is the wrapper for the UIAPicker and UIAPickerWheel class.
  # The UIAPicker class allows users to interact with picker controls. UIAPicker is a subclass of UIAElement
    class Picker < Element

    ##
    # Returns an array of strings that represent the values in the specified wheel.
    #
    # ==== Parameters
    #
    # * +index+ - The wheel to query for values.
    #
    # ==== Examples
    #
    #   date_picker = Cumber::Picker.new(:name => "ElementSearch") <br>
    #   date_picker.values_for_wheel(0) #=> ["value1", "value2"]

    def values_for_wheel(index)
      response = search_and_execute_command("wheels()[#{index}].values()")
      response = ResponseHelper.process_string_response(response)

      if response
        response.split(',')
      else
        []
      end

    end

    ##
    # Returns a string that represents the selected value in the specified wheel.
    #
    # ==== Parameters
    #
    # * +index+ - The wheel to query for values.
    #
    # ==== Examples
    #
    #   date_picker = Cumber::Picker.new(:name => "ElementSearch") <br>
    #   date_picker.selected_value_for_wheel(0) #=> "value1"

    def selected_value_for_wheel(index)
      response = search_and_execute_command("wheels()[#{index}].value()")
      ResponseHelper.process_string_response(response)
    end


    ##
    # Sets the specified wheel index to the first value that matches the value paramater
    #
    # ==== Parameters
    #
    # * +index+ - The wheel index to set.
    # * +value+ - The value to search for and select in the wheel
    #
    # ==== Examples
    #
    #   date_picker = Cumber::Picker.new(:name => "ElementSearch") <br>
    #   date_picker.set_wheel_to_value(0, "value1")

    def set_wheel_to_value(index, value)
      text = value.gsub("'","\\\\\\\\'")
      response = search_and_execute_command("wheels()[#{index}].selectValue('#{text}')")
      ResponseHelper.process_operation_response(response)
    end
  end
end