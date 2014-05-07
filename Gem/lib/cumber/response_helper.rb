module Cumber

  ##
  # Provides helper methods to process different response types.
  class ResponseHelper

    ##
    # Processes the result for a string return. Returns the string or nil if there was an error.
    #
    # ==== Parameters
    #
    # * +response+ - The response from the executing a cumber command.
    #
    # ==== Examples
    #
    #   ResponseHelper.process_string_response {'message'=>'item located', 'status'=>'success'}

    def self.process_string_response(response)
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
    #   ResponseHelper.process_bool_response {'message'=>'true', 'status'=>'success'}

    def self.process_bool_response(response)

      if response['status'] == 'error'
        return nil
      end

      response['message'].to_bool
    end

    ##
    # Processes the result for a json return. Returns a hash that represents the json.
    #
    # ==== Parameters
    #
    # * +response+ - The response from the executing a cumber command.
    #
    # ==== Examples
    #
    #   result = ResponseHelper.process_hash_response {'message'=>"{:x => '22', :y => '33'}", 'status'=>'success'}
    #   result[:x] #=> 22

    def self.process_hash_response(response)

      if response['status'] == 'error'
        return nil
      end

      eval(response['message'])
    end

    ##
    # Processes the result of an opperation action. If the status is of type 'error' the operation throws an warning. If not the operation returns the boolean true.
    #
    # ==== Parameters
    #
    # * +response+ - The response from the executing a cumber command.
    #
    # ==== Examples
    #
    #   result = ResponseHelper.process_operation_response {'message'=>"", 'status'=>'success'}
    #   result #=> true

    def self.process_operation_response(response)

      if response['status'] == 'error'
        raise response['message']
      end

      response['status'] != 'error'
    end

  end
end
