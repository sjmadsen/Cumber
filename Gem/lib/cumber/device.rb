module Cumber

  ##
  # Device allows the user to control different settings over the physical hardware such as orientation.
  class Device
    include Cumber

    @orientation_strings = ['UIA_DEVICE_ORIENTATION_UNKNOWN', 'UIA_DEVICE_ORIENTATION_PORTRAIT', 'UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN', 'UIA_DEVICE_ORIENTATION_LANDSCAPELEFT', 'UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT', 'UIA_DEVICE_ORIENTATION_FACEUP', 'UIA_DEVICE_ORIENTATION_FACEDOWN']
    ##
    # Set the orientation of the device.
    #
    # === Orientations
    # UIA_DEVICE_ORIENTATION_UNKNOWN
    # UIA_DEVICE_ORIENTATION_PORTRAIT
    # UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN
    # UIA_DEVICE_ORIENTATION_LANDSCAPELEFT
    # UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT
    # UIA_DEVICE_ORIENTATION_FACEUP
    # UIA_DEVICE_ORIENTATION_FACEDOWN
    #
    # ==== Parameters
    #
    # * +orientation+ - The desired orientation to rotate the device to
    #
    # ==== Examples
    #
    #   Cumber::Device.set_orientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT)

    def self.set_orientation orientation

      response = Cumber.execute_step('target.setDeviceOrientation('+ orientation +')')
      ResponseHelper.process_operation_response(response)
    end

    ##
    # Set the orientation of the device.
    #
    # === Orientations
    # UIA_DEVICE_ORIENTATION_UNKNOWN
    # UIA_DEVICE_ORIENTATION_PORTRAIT
    # UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN
    # UIA_DEVICE_ORIENTATION_LANDSCAPELEFT
    # UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT
    # UIA_DEVICE_ORIENTATION_FACEUP
    # UIA_DEVICE_ORIENTATION_FACEDOWN
    #
    # ==== Examples
    #
    #   Cumber::Device.orientation #=> UIA_DEVICE_ORIENTATION_LANDSCAPELEFT

    def self.orientation
      response = Cumber.execute_step('target.deviceOrientation()')
      @orientation_strings[response['message'].to_i]
    end

  end
end