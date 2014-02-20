require_relative '../spec_helper'

describe 'UIAKeyboard Wrapper' do

  context 'Providing the search description' do

    it 'should return the path to the keyboard' do
      expected = %q[frontApp.keyboard()]
      Cumber::Keyboard.new().search_description.should eql expected
    end
  end

  context 'Type string into keyboard' do

    it 'should attempt to locate the keyboard and type the values' do

      command = %q[frontApp.keyboard().typeString('Hello')]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      Cumber::Keyboard.new().type_string('Hello')

    end

    it 'should be able to type apostrophes' do
      command = %q[frontApp.keyboard().typeString('Hello\\\\'s')]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      Cumber::Keyboard.new().type_string("Hello's")
    end

    it 'should be able to type quotes' do
      command = %q[frontApp.keyboard().typeString('Then he said "Hello"')]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      Cumber::Keyboard.new().type_string('Then he said "Hello"')
    end

  end

  context 'Search for the keyboard and perform command' do

      it 'should return the result' do
        command = %q[frontApp.keyboard().doStuff()]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Did Stuff', 'status' => 'success')
        Cumber::Keyboard.new().search_and_execute_command('doStuff()')
      end
  end


end