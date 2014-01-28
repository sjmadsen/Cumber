require_relative '../spec_helper'

describe 'UIAKeyboard Wrapper' do

  context 'Providing the search description' do

    it 'should return the path to the keyboard' do
      expected = %q[frontApp.keyboard()]
      Cumber::Keyboard.search_description.should eql expected
    end
  end

  context 'Type string into keyboard' do

    it 'should attempt to locate the keyboard and type the values' do

      command = %q[frontApp.keyboard().typeString('Hello')]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      Cumber::Keyboard.type_string('Hello')

    end

    context 'Element was located' do

      it 'should return true if successful' do

        Cumber.should_receive(:execute_step).and_return('message' => 'undefined', 'status' => 'success')
        Cumber::Keyboard.type_string('Hello').should == true
      end

    end

    context 'Element was not located' do

      it 'should fail the step' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        lambda{ Cumber::Keyboard.type_string('Hello')}.should raise_error
      end

    end

  end

  context 'Search for the keyboard and perform command' do

    context 'Element was found' do

      it 'should return the result' do
        command = %q[frontApp.keyboard().doStuff()]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Did Stuff', 'status' => 'success')
        Cumber::Keyboard.search_and_execute_command('doStuff()').should == {'message'=>'Did Stuff', 'status'=>'success'}
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do
        command = %q[frontApp.keyboard().doStuff()]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'error')
        Cumber::Keyboard.search_and_execute_command('doStuff()').should == {'message'=>'', 'status'=>'error'}
      end

    end

  end


end