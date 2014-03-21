module Cumber

  ##
  # This class is the wrapper for the UIAPopover class.
  # The UIAPopover class allows users to interact with popover controls. UIAPopover is a subclass of UIAElement
  class Popover < Element

    ##
    # Dismisses the selected popover
    #
    # ==== Examples
    #
    #   Cumber::Popover.new(:label => 'thePopover').dismiss

    def dismiss
      response = self.search_and_execute_command('dismiss()')
      response['status'].should_not == 'error'
      response['status'] != 'error'
    end
  end
end