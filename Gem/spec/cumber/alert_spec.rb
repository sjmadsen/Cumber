require_relative '../spec_helper'

describe 'UIAAlert Wrapper' do

  context 'Providing the search description' do

    it 'should return the path to the alert' do
      expected = %q[frontApp.alert()]
      Cumber::Alert.new().search_description.should eql expected
    end
  end

  context 'Getting the alert view title' do

    it 'should attempt to get the alert title' do

      command = %q[frontApp.alert().scrollViews()[0].staticTexts()[0].value()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Title', 'status' => 'success')
      Cumber::Alert.new().title.should eql 'Title'

    end
  end

  context 'Getting the alert view message' do

    it 'should attempt to get the alert title' do

      command = %q[frontApp.alert().scrollViews()[0].staticTexts()[1].value()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Something Happened Take notice', 'status' => 'success')
      Cumber::Alert.new().message.should eql 'Something Happened Take notice'

    end
  end

  context 'Wait until alert view appears' do

    it 'should send the command to wait until the alert appears' do

      command = %q[waitForCondition("frontApp.alert()", 'checkIsValid() == 1', 5)]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Something Happened Take notice', 'status' => 'success')
      Cumber::Alert.new.wait_for_element_to_exist(5)

    end
  end

end