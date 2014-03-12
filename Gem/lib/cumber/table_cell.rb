module Cumber

  ##
  # This class is the wrapper for the UIATableCell class.
  # The UIATableCell class allows users to interact with table objects. UIATableCell is a subclass of UIAElement
  class TableCell < Element

    ##
    # Returns a boolean representing of the cell is currently selected or not.<br>
    #
    # ==== Examples
    #
    #   table_cell = Cumber::TableCell.new(:label => "testCell") <br>
    #   table_cell.is_selected? #=> returns true or false

    def is_selected?
      response = search_and_execute_command('value()')
      ResponseHelper.process_bool_response(response)
    end

  end
end