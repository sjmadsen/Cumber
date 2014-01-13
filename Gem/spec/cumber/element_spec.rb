require_relative '../spec_helper'

describe 'UIAElement Wrapper' do

  context 'Creating a new element with a name' do

    it 'should create an element with an accessible name' do
      cumber_element = Cumber::Element.new('ItemName')
      cumber_element.name.should eq 'ItemName'
    end
  end
  
  context 'Find Element' do

  end
  
  context 'Find Element With name' do

    it 'should find the element and return the description of the element' do

      command = "mainWindow.withName('ItemName');"

      Cumber.should_receive(:execute_step).with(command)
      element_desc = Cumber::Element.find_by_name('ItemName')

    end

  end
end