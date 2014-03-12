require_relative '../spec_helper'

describe 'UIATableCell Wrapper' do

  it 'should attempt to see if the button is selected or not' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).value()]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => '1', 'status' => 'success')
    test_cell = Cumber::TableCell.new(:label => 'ItemLabel')
    test_cell.is_selected?.should == true
  end

end