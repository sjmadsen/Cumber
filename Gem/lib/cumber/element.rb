module Cumber

  ##
  # This class is the wrapper for the generic UIAElement class.
  # The UIAElement class is the UIAutomation superclass for all user interface objects.

  class Element
    include Cumber

    # Represents the accessibiltyLabel of the UIAElement.
    attr_accessor :name

    # Represents the label attribute of the UIAElement. (often this is the same as the name attribute)
    attr_accessor :label

    ##
    # Creates an instance of a Cumber Element to use as a base to query UI Automation.
    #
    # ==== Parameters
    #
    # * +locator+ - A hash of values used to locate a UIAElement.
    #
    # ==== Locators
    #
    # * +:name+ - Represents the accessibiltyLabel of the UIAElement.
    #
    # ==== Examples
    #
    #   Cumber::Element.new(:name => "ElementSearch")

    def initialize(locator = {})
      @name = locator[:name]
      @label = locator[:label]
    end

    ##
    # Returns the locator string to find the specified object based on the set locators.

    def search_description

      predicate = []

      if @name
        predicate << "name = '#{@name}'"
      end

      if @label
        predicate << "label = '#{@label}'"
      end

      %q[searchWithPredicate("] + predicate.join(' AND ') + %q[", mainWindow)]

    end

    ##
    # Appends the command to execute on the located object and returns the response.
    #
    # ==== Parameters
    #
    # * +command+ - The additional step to execute on a UIAElement.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.search_and_execute_command "label()"

    def search_and_execute_command(command)

      step = search_description + '.' + command
      Cumber.execute_step(step)
    end

    ##
    # Processes the result for a string return. Returns the string or nil if there was an error.
    #
    # ==== Parameters
    #
    # * +response+ - The response from the executing a cumber command.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.process_string_response {'message'=>'item located', 'status'=>'success'}

    def process_string_response(response)
      if response['status'] == 'error'
        return nil
      end

      response['message']
    end

    ##
    # Processes the result for a boolean return. Returns the boolean or nil if there was an error.
    #
    # ==== Parameters
    #
    # * +response+ - The response from the executing a cumber command.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.process_bool_response {'message'=>'true', 'status'=>'success'}

    def process_bool_response(response)

      if response['status'] == 'error'
        return nil
      end

      response['message'].to_bool
    end

    ##
    # Returns the label value for the specified Element. <br>
    # See <a href = "https://developer.apple.com/library/ios/documentation/ToolsLanguages/Reference/UIAElementClassReference/UIAElement/UIAElement.html#//apple_ref/javascript/instm/UIAElement/label">Apple's UIAElement Documentation</a> for more information on the differences between name and label.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.label #=> returns the value of the label

    def label

      if @label
        return @label
      end

      response = self.search_and_execute_command('label()')
      process_string_response(response)
    end

    ##
    # Returns the name value for the specified Element. <br>
    # See <a href = "https://developer.apple.com/library/ios/documentation/ToolsLanguages/Reference/UIAElementClassReference/UIAElement/UIAElement.html#//apple_ref/javascript/instm/UIAElement/label">Apple's UIAElement Documentation</a> for more information on the differences between name and label.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:label => "ElementSearch") <br>
    #   element.name #=> returns the value of the accessibilityLabel

    def name

      if @name
        return @name
      end

      response = self.search_and_execute_command('name()')
      process_string_response(response)
    end

    ##
    # Returns the value attribute for the specified Element. <br>
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.value #=> returns the value attribute "Element Found"

    def value

      response = search_and_execute_command('value()')
      process_string_response(response)
    end

    ##
    # Checks the validity attribute and verifies the object exists. <br>
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.exists? #=> returns true If the element exists

    def exists?

      response = search_and_execute_command('checkIsValid()')

      if response['status'] == 'error'
        return false
      end

      response['message'].to_bool
    end

    ##
    # Checks the enabled stated of the object. <br>
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.enabled? #=> returns true If the element is enabled

    def enabled?

      response = search_and_execute_command('isEnabled()')

      process_bool_response(response)
    end


    ##
    # Checks the visibility stated of the object. <br>
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.visible? #=> returns true If the element is visible

    def visible?

      response = search_and_execute_command('isVisible()')

      process_bool_response(response)
    end

    ##
    # Simulate a user tapping on the UIAElement. <br>
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.tap

    def tap

      response = search_and_execute_command('tap()')

      response['status'].should_not == 'error'
      response['status'] != 'error'
    end

  end

end