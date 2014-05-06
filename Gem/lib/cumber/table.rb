module Cumber

  ##
  # This class is the wrapper for the UIATable class.
  # The UIATable class allows users to interact with table objects. UIATable is a subclass of UIAElement
  class Table < Element

    ##
    # Returns a hash describing the cells of the specified table.<br>
    #
    # ==== Examples
    #
    #   table = Cumber::Table.new(:label => "testTable") <br>
    #   table.cells #=> returns an array of hashes describing the cells

    def cells
      response = search_and_execute_command('cells().description()')
      response = ResponseHelper.process_hash_response(response)

      unless response
        response = []
      end

      response
    end

    ##
    # Returns a hash describing the groups of the specified table.<br>
    #
    # ==== Examples
    #
    #   table = Cumber::Table.new(:label => "testTable") <br>
    #   table.groups #=> returns an array of hashes describing the groups

    def groups
      response = search_and_execute_command('groups().description()')
      ResponseHelper.process_hash_response(response)
    end

  end
end
