module Cumber

  ##
  # This class is the wrapper for the generic UIAElement class.
  # The UIAElement class is the UIAutomation superclass for all user interface objects.

class Element
    include Cumber

    # Represents the accessibiltyLabel of the UIAElement.
    attr_accessor :name

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
    #   element = Cumber::Element.new(:name => "ElementSearch")

    def initialize(locator = {})
      @name = locator[:name]
    end

    ##
    # Searches the main window for any UIAElement which has an accessibility label that matches the name on the Cumber Element, and returns if the object exists or not.
    #
    # ==== Examples
    #
    #   element = Cumber::Element.new(:name => "ElementSearch") <br>
    #   element.find_by_name

    def find_by_name

      predicate = "name = '#{@name}'"

      command = %q[searchWithPredicate("] + predicate + %q[", mainWindow).checkIsValid()]
      Cumber.execute_step(command).to_bool
    end

    ##
    # Returns the locator string to find the specified object based on the set locators.

    def search_description

      predicate = "name = '#{@name}'"

      %q[searchWithPredicate("] + predicate + %q[", mainWindow)]

    end

  end

end