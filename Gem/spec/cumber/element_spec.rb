require_relative '../spec_helper'

describe 'UIAElement Wrapper' do

  context 'Creating a new element' do

    it 'should be able to create an element with the name locator' do
      cumber_element = Cumber::Element.new(:name => 'ItemName')
      cumber_element.name.should eq 'ItemName'
    end


    it 'should be able to create an element with the name locator' do
      cumber_element = Cumber::Element.new(:label => 'ItemLabel')
      cumber_element.label.should eq 'ItemLabel'
    end


  end

  context 'Providing the search description' do

    it 'should return the search command with the name predicate for the object' do
      expected = %q[searchWithPredicate("name = 'ItemName'", mainWindow)]
      element = Cumber::Element.new(:name => 'ItemName')
      element.search_description.should eql expected
    end

    it 'should return the search command with the label predicate for the object' do
      expected = %q[searchWithPredicate("label = 'ItemLabel'", mainWindow)]
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.search_description.should eql expected
    end

    it 'should return the search command with the name & label predicate for the object' do
      expected = %q[searchWithPredicate("name = 'ItemName' AND label = 'ItemLabel'", mainWindow)]
      element = Cumber::Element.new(:name => 'ItemName', :label => 'ItemLabel')
      element.search_description.should eql expected
    end

  end

  context 'Search For an object and perform command' do

    context 'Element was found' do

      it 'should return the result' do
        command = %q[searchWithPredicate("name = 'ItemName'", mainWindow).doStuff()]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Did Stuff', 'status' => 'success')
        element = Cumber::Element.new(:name => 'ItemName')
        element.search_and_execute_command('doStuff()').should == {'message'=>'Did Stuff', 'status'=>'success'}
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do
        command = %q[searchWithPredicate("name = 'ItemNotThere'", mainWindow).doStuff()]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:name => 'ItemNotThere')
        element.search_and_execute_command('doStuff()').should == {'message'=>'', 'status'=>'error'}
      end

    end

  end

  context 'Getting the label value' do

    it 'should return the set label variable if created with label' do
      Cumber.should_not_receive(:execute_step)
      element = Cumber::Element.new(:label => 'ExistingLabel')
      element.label.should == 'ExistingLabel'
    end

    it 'should attempt to locate the element and return the label' do

      command = %q[searchWithPredicate("name = 'ItemName'", mainWindow).label()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'ItemLabel', 'status' => 'success')
      element = Cumber::Element.new(:name => 'ItemName')
      element.label

    end

    context 'Element was found' do

      it 'should return the result' do

        Cumber.should_receive(:execute_step).and_return('message' => 'ItemLabel', 'status' => 'success')
        element = Cumber::Element.new(:name => 'ItemName')
        element.label.should == 'ItemLabel'
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:name => 'ItemNotThere')
        element.label.should == nil
      end

    end

  end

  context 'Getting the name value' do

    it 'should return the set name variable if created with name' do
      Cumber.should_not_receive(:execute_step)
      element = Cumber::Element.new(:name => 'ExistingName')
      element.name.should == 'ExistingName'
    end

    it 'should attempt to locate the element and return the name' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", mainWindow).name()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'ItemName', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.name

    end

    context 'Element was found' do

      it 'should return the result' do

        Cumber.should_receive(:execute_step).and_return('message' => 'ItemName', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.name.should == 'ItemName'
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.name.should == nil
      end

    end

  end

  context 'Getting the value attribute' do

    it 'should attempt to locate the element and return the value' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", mainWindow).value()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Item Found', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.value

    end

    context 'Element was found' do

      it 'should return the result' do

        Cumber.should_receive(:execute_step).and_return('message' => 'Item Found', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.value.should == 'Item Found'
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.value.should == nil
      end

    end

  end

  context 'Check the validity state of the element' do

    it 'should attempt to locate the element and return if it exists' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", mainWindow).checkIsValid()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'true', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.exists?

    end

    context 'Element was found' do

      it 'should return the boolean true if valid' do

        Cumber.should_receive(:execute_step).and_return('message' => 'true', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.exists?.should == true
      end

      it 'should return the boolean false if invalid' do

        Cumber.should_receive(:execute_step).and_return('message' => 'false', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.exists?.should == false
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.exists?.should == false
      end

    end

  end

  context 'Check the enabled state of the element' do

    it 'should attempt to locate the element and return if it is enabled' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", mainWindow).isEnabled()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'true', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.enabled?

    end

    context 'Element was found' do

      it 'should return the boolean true if enabled' do

        Cumber.should_receive(:execute_step).and_return('message' => '1', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.enabled?.should == true
      end

      it 'should return the boolean false if disabled' do

        Cumber.should_receive(:execute_step).and_return('message' => '0', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.enabled?.should == false
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.enabled?.should == nil
      end

    end

  end

  context 'Check the visibility state of the element' do

    it 'should attempt to locate the element and return if it is visible' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", mainWindow).isVisible()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'true', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.visible?

    end

    context 'Element was found' do

      it 'should return the boolean true if the element is visible' do

        Cumber.should_receive(:execute_step).and_return('message' => '1', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.visible?.should == true
      end

      it 'should return the boolean false if hidden' do

        Cumber.should_receive(:execute_step).and_return('message' => '0', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.visible?.should == false
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.visible?.should == nil
      end

    end

  end

  context 'Tap an element' do

    it 'should attempt to locate the element and return if it is visible' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", mainWindow).tap()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.tap

    end

    context 'Element was located' do

      it 'should fail the step' do

        Cumber.should_receive(:execute_step).and_return('message' => 'undefined', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.tap.should == true
      end

    end

    context 'Element was not located' do

      it 'should fail the step' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        lambda{ element.tap}.should raise_error
      end

    end

  end

end
