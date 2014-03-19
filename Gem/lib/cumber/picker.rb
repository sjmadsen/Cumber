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
  end
end