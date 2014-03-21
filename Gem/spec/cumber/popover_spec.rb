require_relative '../spec_helper'

describe 'UIAPopover Wrapper' do

  it 'should dismiss the popover' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).dismiss()]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'success')

    Cumber::Popover.new(:label => 'ItemLabel').dismiss
  end

end