module Cumber

  ##
  # This class is the wrapper for the UIAButton class.
  # The UIAButton class allows users to interact with button objects. UIAButton is a subclass of UIAElement

  class Button < Element

    ##
    # Returns the title for the specified Button.<br>
    #
    # <b>Note:</b> This requires the Cumber extension classes.
    #
    # ==== Examples
    #
    #   element = Cumber::Button.new(:label => "ElementSearch") <br>
    #   element.title #=> returns the title of the button

    def title
      response = self.search_and_execute_command('name()')
      ResponseHelper.process_string_response(response)
    end

    ##
    # Returns if the specified Button is selected or not.<br>
    #
    # ==== Examples
    #
    #   element = Cumber::Button.new(:label => "ElementSearch") <br>
    #   element.is_selected #=> returns true

    def is_selected?
      response = self.search_and_execute_command('value()')
      ResponseHelper.process_bool_response(response)
    end

  end
end
