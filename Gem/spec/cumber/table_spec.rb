require_relative '../spec_helper'

describe 'UIATable Wrapper' do

  it 'should attempt to get the cells in the table' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).cells().description()]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => "[[:name => 'hello'], [:name => 'hello2']]", 'status' => 'success')
    test_table = Cumber::Table.new(:label => 'ItemLabel')
    test_table.cells
  end

  it 'should attempt to get the groups in the table' do

    command = %q[searchWithPredicate("label = 'ItemLabel'", target).groups().description()]
    Cumber.should_receive(:execute_step).with(command).and_return('message' => "[[:name => 'hello'], [:name => 'hello2']]", 'status' => 'success')
    test_table = Cumber::Table.new(:label => 'ItemLabel')
    test_table.groups
  end

end