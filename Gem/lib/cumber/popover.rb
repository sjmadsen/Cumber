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
      ResponseHelper.process_operation_response(response)
    end
  end
end