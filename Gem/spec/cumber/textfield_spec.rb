require_relative '../spec_helper'

describe 'UIATextField Wrapper' do

  it 'should attempt to set the text of the text field' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).setValue('Hello')]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'success')
    text_field = Cumber::TextField.new(:label => 'ItemLabel')
    text_field.set_value('Hello')
  end

end