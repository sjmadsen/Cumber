module Cumber

  ##
  # This class is the wrapper for the generic UIAElement class.
  # The UIAElement class is the UIAutomation superclass for all user interface objects.

  class Element
    include Cumber

    # Represents the label attribute of the UIAElement. (often this is the same as the name attribute)
    attr_accessor :name

    # Represents the accessibiltyLabel of the UIAElement.
    attr_accessor :label

    # Represents the ancestry path of the UIAElement
    attr_accessor :ancestry

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
      @ancestry = locator[:ancestry]
    end

    ##
    # Returns the search predicate to use when locating objects

    def search_predicate
      predicate = []

      if @name
        predicate << "name = '#{escape_single_quotes(@name)}'"
      end

      if @label
        predicate << "label = '#{escape_single_quotes(@label)}'"
      end

      predicate.join(' AND ')

    end

    ##
    # Returns the locator string to find the specified object based on the set locators.

    def search_description

      if @ancestry
        @ancestry
      else
        %q[searchWithPredicate("] + search_predicate + %q[", target)]
      end
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
    # Waits until a particular condition is met in the provided time period. Returns if the condition is met or not after the provided timeout.
    #
    # ==== Parameters
    #
    # * +condition+ - The condition to to verify the command must be the UIInstruments Command.
    #
    # ==== Optional Parameters
    #
    # * +timeout+ - The amount of time to wait before giving up.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.wait_for_condition('isValid() == true', 3000)

    def wait_for_condition(condition, timeout = 3000)
      step = %q[waitForCondition(] + search_description + %q[, '] + condition + %q[', ] + timeout.to_s + %q[)]
      response = Cumber.execute_step(step)

      ResponseHelper.process_bool_response(response)
    end

    ##
    # Waits until the element exists over the given time period. Returns if element exists or not after the provided timeout.
    #
    # ==== Optional Parameters
    #
    # * +timeout+ - The amount of time to wait before giving up.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.wait_for_element_to_exist(3000)

    def wait_for_element_to_exist(timeout = 3000)

      step = %q[waitForElementToExist("] + search_predicate + %q[", target, ] + timeout.to_s + %q[).checkIsValid()]
      response = Cumber.execute_step(step)

      if ResponseHelper.process_bool_response(response) then
        true
      else
        false
      end
    end

    ##
    # Waits until the element is visible over the given time period. Returns if element is visible or not after the provided timeout.
    #
    # ==== Optional Parameters
    #
    # * +timeout+ - The amount of time to wait before giving up.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.wait_for_element_to_be_visible(3000)

    def wait_for_element_to_be_visible(timeout = 3000)

      wait_for_condition('isVisible() == true', timeout)
    end

    ##
    # Waits until the element is enabled over the given time period. Returns if element is enabled or not after the provided timeout.
    #
    # ==== Optional Parameters
    #
    # * +timeout+ - The amount of time to wait before giving up.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.wait_for_element_to_be_enabled(3000)

    def wait_for_element_to_be_enabled(timeout = 3000)

      wait_for_condition('isEnabled() == 1', timeout)
    end


    ##
    # Returns the accessibilityLabel value for the specified Element. <br>
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
      ResponseHelper.process_string_response(response)
    end

    ##
    # Returns the name value for the specified Element.<br>
    # Often this is the same as the accessibilityLabel. One notable difference is when working with an Image View. The name will represent the file path to the image being displayed <br>
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
      ResponseHelper.process_string_response(response)
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
      ResponseHelper.process_string_response(response)
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

      ResponseHelper.process_bool_response(response)
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

      ResponseHelper.process_bool_response(response)
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

      ResponseHelper.process_operation_response(response)
    end

    ##
    # Allows for tapping an element with more control.
    #
    # ==== Options
    # * +:tap_count+ - The number of times to tap the specified element.
    # * +:touch_count+ - The number touches (aka fingers a user would use) to tap the specified element.
    # * +:duration+ - The length of hold the touch.
    # * +:offset+ - This will offset the tap for the specified element. The offset is based on percentage where {:x => 0.0, :y => 0.0} would signify the top left, {:x => 1.0, :y => 1.0} would signify the bottom right
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch")
    #   element.tap_with_options(:tap_count => 2, :touch_count => 1, :duration => 0, :offset => {:x => 0.5, :y => 0.0})

    def tap_with_options(options={})

      tap_options = []

      if options[:tap_count]
        tap_options << "tapCount:#{options[:tap_count]}"
      end

      if options[:touch_count]
        tap_options << "touchCount:#{options[:touch_count]}"
      end

      if options[:duration]
        tap_options << "duration:#{options[:duration]}"
      end

      if options[:offset]
        tap_options << "tapOffset:{x:#{options[:offset][:x]}, y:#{options[:offset][:y]}}"
      end

      response = search_and_execute_command('tapWithOptions({'+ tap_options.join(', ') +'})')

      ResponseHelper.process_operation_response(response)
    end

    ##
    # Returns the position :x, :y touched by the UIAElement Tap method <br>
    #
    # ==== Returned Hash Variables
    #
    # * +:x+ - The x coordinate tapped by the tap command.
    # * +:y+ - The y coordinate tapped by the tap command.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   point = element.hit_point
    #   point[:x] #=> "22"
    #   point[:y] #=> "123"

    def hit_point

      response = search_and_execute_command('hit_point()')
      ResponseHelper.process_hash_response(response)
    end

    ##
    # Returns the frame origin :x, :y and size :width, :height of the UIAElement. <br>
    #
    # ==== Origin
    #
    # * +:x+ - The left most x coordinate of the UIAElement.
    # * +:y+ - The top most y coordinate of the UIAElement.
    #
    # ==== size
    #
    # * +:width+ - The left most x coordinate of the UIAElement.
    # * +:height+ - The top most y coordinate of the UIAElement.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   frame = element.frame
    #   frame[:origin][:x] #=> "22"
    #   frame[:origin][:y] #=> "123"
    #   frame[:size][:width] #=> "200"
    #   frame[:size][:height] #=> "50"

    def frame

      response = search_and_execute_command('frame()')
      ResponseHelper.process_hash_response(response)
    end

    ##
    # Returns if the selected element has the focus of the keyboard. <br>
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.has_keyboard_focus? #=> true or false

    def has_keyboard_focus?

      response = search_and_execute_command('hasKeyboardFocus()')
      ResponseHelper.process_bool_response(response)
    end

    ##
    # Returns the class of the specified object <br>
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.type #=> UIAStaticText

    def type

      response = search_and_execute_command('type()')
      ResponseHelper.process_string_response(response)
    end

    ##
    # Returns the description of the element. Mirrors the behavior of logElement() in UI Automation
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   description = element.description
    #   description[:type] #=> UIAStaticText
    #   description[:label] #=> ElementSearchLabel
    #   description[:name] #=> ElementSearch
    #   description[:frame][:origin][:x] #=> "22"
    #   description[:frame][:origin][:y] #=> "123"
    #   description[:frame][:size][:width] #=> "200"
    #   description[:frame][:size][:height] #=> "50"
    #   description[:value] #=> "The label is here"

    def description

      response = search_and_execute_command('description()')
      ResponseHelper.process_hash_response(response)
    end

    ##
    # Returns the description of the target element and as well as the description for all sub elements. Mirrors the behavior of logElementTree() in UI Automation
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   description = element.element_tree
    #   description[:type] #=> UIAStaticText
    #   description[:label] #=> ElementSearchLabel
    #   description[:name] #=> ElementSearch
    #   description[:frame][:origin][:x] #=> "22"
    #   description[:frame][:origin][:y] #=> "123"
    #   description[:frame][:size][:width] #=> "200"
    #   description[:frame][:size][:height] #=> "50"
    #   description[:value] #=> "The label is here"
    #   description[:child_elements] #=> [child_element0-description, child_element1-description, ...]

    def element_tree

      response = search_and_execute_command('element_tree()')
      ResponseHelper.process_hash_response(response)
    end

    ##
    # Returns an array of descriptions about each element that is a direct subview of the listed element.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   descriptions = element.elements

    def elements

      response = search_and_execute_command('elements().description()')
      ResponseHelper.process_hash_response(response)
    end

    ##
    # Escapes single quotes for sending commands

    def escape_single_quotes(value)
      value.gsub("'", "\\\\\\\\\\\\'")
    end

  end

end