require_relative '../spec_helper'

describe 'UIATarget Wrapper' do

  context 'Get the device orientation' do

    it 'should attempt to get the orientation of the device' do

      command = %q[target.deviceOrientation()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '1', 'status' => 'success')
      Cumber::Device.orientation
    end

    it 'should return UIA_DEVICE_ORIENTATION_UNKNOWN for value 0' do

      command = %q[target.deviceOrientation()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '0', 'status' => 'success')
      Cumber::Device.orientation.should eql 'UIA_DEVICE_ORIENTATION_UNKNOWN'
    end


    it 'should return UIA_DEVICE_ORIENTATION_PORTRAIT for value 1' do

      command = %q[target.deviceOrientation()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '1', 'status' => 'success')
      Cumber::Device.orientation.should eql 'UIA_DEVICE_ORIENTATION_PORTRAIT'
    end

    it 'should return UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN for value 2' do

      command = %q[target.deviceOrientation()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '2', 'status' => 'success')
      Cumber::Device.orientation.should eql 'UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN'
    end

    it 'should return UIA_DEVICE_ORIENTATION_LANDSCAPELEFT for value 3' do

      command = %q[target.deviceOrientation()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '3', 'status' => 'success')
      Cumber::Device.orientation.should eql 'UIA_DEVICE_ORIENTATION_LANDSCAPELEFT'
    end

    it 'should return UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT for value 4' do

      command = %q[target.deviceOrientation()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '4', 'status' => 'success')
      Cumber::Device.orientation.should eql 'UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT'
    end

    it 'should return UIA_DEVICE_ORIENTATION_FACEUP for value 5' do

      command = %q[target.deviceOrientation()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '5', 'status' => 'success')
      Cumber::Device.orientation.should eql 'UIA_DEVICE_ORIENTATION_FACEUP'
    end

    it 'should return UIA_DEVICE_ORIENTATION_FACEDOWN for value 6' do

      command = %q[target.deviceOrientation()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '6', 'status' => 'success')
      Cumber::Device.orientation.should eql 'UIA_DEVICE_ORIENTATION_FACEDOWN'
    end

  end

  context 'set the device orientation' do

    it 'should attempt to set the orientation of the device' do
      command = %q[target.setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT)]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'success')
      Cumber::Device.set_orientation('UIA_DEVICE_ORIENTATION_LANDSCAPELEFT')
    end

    context 'An error occured' do

      it 'should throw an error' do
        command = %q[target.setDeviceOrientation(Not_An_Orientation)]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'error')
        lambda { Cumber::Device.set_orientation('Not_An_Orientation') }.should raise_error
      end

    end

    context 'the operation was successful' do

      it 'should return true' do

        command = %q[target.setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT)]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'success')
        Cumber::Device.set_orientation('UIA_DEVICE_ORIENTATION_LANDSCAPELEFT').should be_true
      end

    end

  end
end