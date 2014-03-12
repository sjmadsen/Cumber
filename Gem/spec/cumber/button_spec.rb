require_relative '../spec_helper'

describe 'UIAButton Wrapper' do

  it 'should return title of the button' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).name()]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => 'The title', 'status' => 'success')
    test_button = Cumber::Button.new(:label => 'ItemLabel')
    test_button.title
  end

  it 'should return if the button is selected or not' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).value()]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => '1', 'status' => 'success')
    test_button = Cumber::Button.new(:label => 'ItemLabel')
    test_button.is_selected?.should == true
  end

end