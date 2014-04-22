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

  context 'Verifying the search predicate to be used when locating the item' do

    it 'should return the search predicate when provided a name' do
      expected = %q[name = 'ItemName']
      element = Cumber::Element.new(:name => 'ItemName')
      element.search_predicate.should eql expected
    end

    it 'should return the search predicate when provided a label' do
      expected = %q[label = 'ItemLabel']
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.search_predicate.should eql expected
    end

    it 'should return the search predicate when provided a name and a label' do
      expected = %q[name = 'ItemName' AND label = 'ItemLabel']
      element = Cumber::Element.new(:name => 'ItemName', :label => 'ItemLabel')
      element.search_predicate.should eql expected
    end

  end

  context 'Providing the search description' do

    it 'should return the search command with the name predicate for the object' do
      expected = %q[searchWithPredicate("name = 'ItemName'", target)]
      element = Cumber::Element.new(:name => 'ItemName')
      element.search_description.should eql expected
    end

    it 'should return the search command with the label predicate for the object' do
      expected = %q[searchWithPredicate("label = 'ItemLabel'", target)]
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.search_description.should eql expected
    end

    it 'should return the search command with the name & label predicate for the object' do
      expected = %q[searchWithPredicate("name = 'ItemName' AND label = 'ItemLabel'", target)]
      element = Cumber::Element.new(:name => 'ItemName', :label => 'ItemLabel')
      element.search_description.should eql expected
    end

    it 'should return the search description when provided the element ancestry' do
      expected = %q[mainWindow.popover[0]]
      element = Cumber::Element.new(:ancestry => 'mainWindow.popover[0]')
      element.search_description.should eql expected
    end

  end

  context 'Search For an object and perform command' do

    context 'Element was found' do

      it 'should return the result' do
        command = %q[searchWithPredicate("name = 'ItemName'", target).doStuff()]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => 'Did Stuff', 'status' => 'success')
        element = Cumber::Element.new(:name => 'ItemName')
        element.search_and_execute_command('doStuff()').should == {'message' => 'Did Stuff', 'status' => 'success'}
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do
        command = %q[searchWithPredicate("name = 'ItemNotThere'", target).doStuff()]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:name => 'ItemNotThere')
        element.search_and_execute_command('doStuff()').should == {'message' => '', 'status' => 'error'}
      end

    end

  end

  context 'Wait for condition to be met' do

    context 'Element was found' do

      it 'should return the result of the condition' do
        command = %q[waitForCondition(searchWithPredicate("name = 'ItemName'", target), 'doStuff()', 3000)]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => 'true', 'status' => 'success')
        element = Cumber::Element.new(:name => 'ItemName')
        element.wait_for_condition('doStuff()').should == true
      end

    end

    context 'Element was not located' do

      it 'should raise an error if the command errors out' do
        command = %q[waitForCondition(searchWithPredicate("name = 'ItemNotThere'", target), 'doStuff()', 200)]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:name => 'ItemNotThere')

        element.wait_for_condition('doStuff()', 200).should == nil
      end

    end

  end

  context 'Wait for element to exist in a given timeout' do

    context 'No error when searching for the element' do

      it 'should return the result of the element search' do
        command = %q[waitForElementToExist("name = 'ItemName'", target, 3000).checkIsValid()]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => 'true', 'status' => 'success')
        element = Cumber::Element.new(:name => 'ItemName')
        element.wait_for_element_to_exist().should == true
      end

    end

    context 'Element was not located' do

      it 'should return false' do
        command = %q[waitForElementToExist("name = 'ItemNotThere'", target, 200).checkIsValid()]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:name => 'ItemNotThere')

        element.wait_for_element_to_exist(200).should == false
      end

    end

  end

  context 'Wait for element to be enabled' do

    context 'Element was found' do

      it 'should return the result if the element was enabled after the timeout' do
        command = %q[waitForCondition(searchWithPredicate("name = 'ItemName'", target), 'isEnabled() == 1', 3000)]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => 'true', 'status' => 'success')
        element = Cumber::Element.new(:name => 'ItemName')
        element.wait_for_element_to_be_enabled().should == true
      end

    end

    context 'Element was not located' do

      it 'should raise an error if the command errors out' do
        command = %q[waitForCondition(searchWithPredicate("name = 'ItemNotThere'", target), 'isEnabled() == 1', 200)]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:name => 'ItemNotThere')

        element.wait_for_element_to_be_enabled(200).should == nil
      end

    end

  end

  context 'Wait for element to be visible' do

    context 'Element was found' do

      it 'should return the result if the element was visible after the timeout' do
        command = %q[waitForCondition(searchWithPredicate("name = 'ItemName'", target), 'isVisible() == true', 3000)]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => 'true', 'status' => 'success')
        element = Cumber::Element.new(:name => 'ItemName')
        element.wait_for_element_to_be_visible().should == true
      end

    end

    context 'Element was not located' do

      it 'should raise an error if the command errors out' do
        command = %q[waitForCondition(searchWithPredicate("name = 'ItemNotThere'", target), 'isVisible() == true', 200)]

        Cumber.should_receive(:execute_step).with(command).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:name => 'ItemNotThere')

        element.wait_for_element_to_be_visible(200).should == nil
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

      command = %q[searchWithPredicate("name = 'ItemName'", target).label()]

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

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).name()]

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

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).value()]

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

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).checkIsValid()]

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

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).isEnabled()]

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

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).isVisible()]

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

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).tap()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.tap

    end

    context 'Element was located' do

      it 'should return the boolean result' do

        Cumber.should_receive(:execute_step).and_return('message' => 'undefined', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.tap.should == true
      end

    end

    context 'Element was not located' do

      it 'should fail the step' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        lambda { element.tap }.should raise_error
      end

    end

  end

  context 'Tap an element with options' do

    it 'should attempt to tap the element with no additional arguments' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).tapWithOptions({})]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.tap_with_options()

    end

    it 'should attempt to tap the element with tap count 2' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).tapWithOptions({tapCount:2})]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.tap_with_options(:tap_count => 2)

    end

    it 'should attempt to tap the element with touch count 4' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).tapWithOptions({touchCount:4})]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.tap_with_options(:touch_count => 4)

    end

    it 'should attempt to tap the element with duration 0.5' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).tapWithOptions({duration:0.5})]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.tap_with_options(:duration => 0.5)

    end

    it 'should attempt to tap the element with offset x = 0.25 y = 0.66' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).tapWithOptions({tapOffset:{x:0.5, y:0.66}})]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'undefined', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.tap_with_options(:offset => {:x => 0.5, :y => 0.66})

    end

  end

  context 'Get the hit point an element' do

    it 'should attempt to locate the element and return if it\'s hit point' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).hit_point()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '{:x => "12", :y => "23"}', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.hit_point

    end

    context 'Element was located' do

      it 'should return the hash for the hit point' do

        Cumber.should_receive(:execute_step).and_return('message' => '{:x => "12", :y => "23"}', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        point = element.hit_point
        point[:x].should == '12'
        point[:y].should == '23'
      end

    end

    context 'Element was not located' do

      it 'should fail the step' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.hit_point.should == nil
      end

    end

  end

  context 'Get the frame of an element' do

    it 'should attempt to locate the element and return if it is visible' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).frame()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '{:origin => {:x => "12", :y => "23"}, :size => {:width => "120", :height => "33"}}', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.frame

    end

    context 'Element was located' do

      it 'should return a hash of the frame' do

        Cumber.should_receive(:execute_step).and_return('message' => '{:origin => {:x => "12", :y => "23"}, :size => {:width => "120", :height => "33"}}', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        frame = element.frame
        frame[:origin][:x].should == '12'
        frame[:origin][:y].should == '23'
        frame[:size][:width].should == '120'
        frame[:size][:height].should == '33'
      end

    end

    context 'Element was not located' do

      it 'should fail the step' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.frame.should == nil
      end

    end

  end

  context 'Check if the element has keyboard focus' do

    it 'should attempt to locate the element and return if it is enabled' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).hasKeyboardFocus()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => '1', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.has_keyboard_focus?

    end

    context 'Element was found' do

      it 'should return the boolean true if it has focus' do

        Cumber.should_receive(:execute_step).and_return('message' => '1', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.has_keyboard_focus?.should == true
      end

      it 'should return the boolean false if does not have focus' do

        Cumber.should_receive(:execute_step).and_return('message' => '0', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.has_keyboard_focus?.should == false
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.has_keyboard_focus?.should == nil
      end

    end

  end

  context 'Get the type of the element' do

    it 'should attempt to locate the element and return its type' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).type()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => 'UIAButton', 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.type

    end

    context 'Element was found' do

      it 'should return the type as a string' do

        Cumber.should_receive(:execute_step).and_return('message' => 'UIAButton', 'status' => 'success')
        element = Cumber::Element.new(:label => 'ItemLabel')
        element.type.should == 'UIAButton'
      end

    end

    context 'Element was not located' do

      it 'should return nil if the element is not found' do

        Cumber.should_receive(:execute_step).and_return('message' => '', 'status' => 'error')
        element = Cumber::Element.new(:label => 'ItemNotThere')
        element.type.should == nil
      end

    end

  end

  context 'Get the description of an element' do

    it 'should attempt to locate the element and return its description' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).description()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => "{:type => 'UIAStaticText', :label => 'ItemLabel', :name => 'ItemName', :value => 'Item Value', :frame => {:origin => {:x => '12', :y => '23'}, :size => {:width => '120', :height => '33'}} }", 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.description

    end

  end

  context 'Get the description of an element and all of its sub elements' do

    it 'should attempt to locate the element and return the element tree from that point on' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).element_tree()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => "{:type => 'UIAStaticText', :label => 'ItemLabel', :name => 'ItemName', :value => 'Item Value', :frame => {:origin => {:x => '12', :y => '23'}, :size => {:width => '120', :height => '33'}} }", 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.element_tree

    end

  end

  context 'Get the list of elements in the object' do

    it 'should attempt to locate the element and return its children' do

      command = %q[searchWithPredicate("label = 'ItemLabel'", target).elements().description()]

      Cumber.should_receive(:execute_step).with(command).and_return('message' => "[[:name => 'hello'], [:name => 'hello2']]", 'status' => 'success')
      element = Cumber::Element.new(:label => 'ItemLabel')
      element.elements

    end

  end

end
