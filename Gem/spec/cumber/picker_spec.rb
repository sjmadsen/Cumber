require_relative '../spec_helper'

describe 'UIAPicker Wrapper' do

  it 'should return the values of a wheel' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).wheels()[2].values()]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Jan,Feb,Mar', 'status' => 'success')
    test_picker = Cumber::Picker.new(:label => 'ItemLabel')
    test_picker.values_for_wheel(2).should == 'Jan,Feb,Mar'.split(',')
  end

  it 'should return the selected value of a wheel' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).wheels()[3].value()]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Feb', 'status' => 'success')
    test_picker = Cumber::Picker.new(:label => 'ItemLabel')
    test_picker.selected_value_for_wheel(3).should == 'Feb'
  end

  it 'should attempt to set the wheel to the specified value' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).wheels()[3].selectValue('value')]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'success')
    test_picker = Cumber::Picker.new(:label => 'ItemLabel')
    test_picker.set_wheel_to_value(3, 'value')
  end

end