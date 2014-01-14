require_relative '../spec_helper'

describe 'UIAElement Wrapper' do

  context 'Creating a new element' do

    it 'should be able to create an element with the name locator' do
      cumber_element = Cumber::Element.new(:name => 'ItemName')
      cumber_element.name.should eq 'ItemName'
    end

  end

  context 'Locating an element by name' do

    it 'should attempt to locate the element by the accessibilityLabel name' do

      command = %q[searchWithPredicate("name = 'ItemName'", mainWindow).checkIsValid()]

      Cumber.should_receive(:execute_step).with(command).and_return('true')
      element = Cumber::Element.new(:name => 'ItemName')
      element.find_by_name

    end

    context 'Element was found' do

      it 'should return the boolean true if the element is found' do
        command = %q[searchWithPredicate("name = 'ItemName'", mainWindow).checkIsValid()]

        Cumber.should_receive(:execute_step).with(command).and_return('true')
        element = Cumber::Element.new(:name => 'ItemName')
        element.find_by_name.should be_true
      end
    end

    context 'Element was not located' do

      it 'should return the boolean true if the element is found' do
        command = %q[searchWithPredicate("name = 'ItemName'", mainWindow).checkIsValid()]

        Cumber.should_receive(:execute_step).with(command).and_return('false')
        element = Cumber::Element.new(:name => 'ItemName')
        element.find_by_name.should be_false
      end
    end

  end

  context 'Providing the search description' do

    it 'should return the search command with the predicate for the object' do
      expected = %q[searchWithPredicate("name = 'ItemName'", mainWindow)]
      element = Cumber::Element.new(:name => 'ItemName')
      element.search_description.should eql expected
    end
  end



end