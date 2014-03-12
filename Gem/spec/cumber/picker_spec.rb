require_relative '../spec_helper'

describe 'UIAPicker Wrapper' do

  it 'should return the values of a wheel' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).wheels()[2].values()]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => '["Jan", "Feb", "Mar"]', 'status' => 'success')
    test_picker = Cumber::Picker.new(:label => 'ItemLabel')
    test_picker.values_for_wheel(2)
  end

end