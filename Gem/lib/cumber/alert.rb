module Cumber

  ##
  # This class is the wrapper for the UIAAlert class.
  # The UIAAlert class allows access and control to alert views presented in the app. UIAAlert is a subclass of UIAElement

  class Alert < Element

    ##
    # Returns the locator string to find the active alert.

    def search_description
      %q[frontApp.alert()]
    end

    ##
    # Returns the title of the active alert
    #
    # ==== Examples
    #
    #   alert = Cumber::Alert.new() <br>
    #   alert.title #=> 'Warning!!'

    def title
      response = self.search_and_execute_command('scrollViews()[0].staticTexts()[0].value()')
      ResponseHelper.process_string_response(response)
    end

    ##
    # Returns the message of the active alert
    #
    # ==== Examples
    #
    #   alert = Cumber::Alert.new() <br>
    #   alert.message #=> 'Stuff Broke!!'

    def message
      response = self.search_and_execute_command('scrollViews()[0].staticTexts()[1].value()')
      ResponseHelper.process_string_response(response)
    end

    ##
    # Taps the confirmation button on the alert
    #
    # ==== Examples
    #
    #   alert = Cumber::Alert.new() <br>
    #   alert.confirm

    def confirm
      response = self.search_and_execute_command('defaultButton().tap()')
      response['status'].should_not == 'error'
      response['status'] != 'error'
    end

    ##
    # Taps the cancel button on the alert
    #
    # ==== Examples
    #
    #   alert = Cumber::Alert.new() <br>
    #   alert.cancel

    def cancel
      response = self.search_and_execute_command('cancelButton().tap()')
      response['status'].should_not == 'error'
      response['status'] != 'error'
    end

    ##
    # Waits until the alert exists over the given time period. Returns if the alert exists or not after the provided timeout.
    #
    # ==== Optional Parameters
    #
    # * +timeout+ - The amount of time to wait before giving up. The default is 5 mins.
    #
    # ==== Examples
    #
    #   alert = Cumber::Alert.new <br>
    #   alert.wait_for_element_to_exist(300)

    def wait_for_element_to_exist(timeout = 300)

      step = %q[waitForCondition("] + search_description + %q[", 'checkIsValid() == 1', ] + timeout.to_s + %q[)]
      response = Cumber.execute_step(step)

      if ResponseHelper.process_bool_response(response) then true else false end
    end

  end
end