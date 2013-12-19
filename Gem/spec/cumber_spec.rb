require 'spec_helper'

describe Cumber do

  context 'Execute Cucumber step' do

    it 'should send the command to server and return the response' do

      step = 'target.frontMostApp().keyboard().typeString("pas&word");'
      Cumber.should_receive('send_command').with(step).and_return('{"message":"result"}')
      Cumber.execute_step(step).should eql('result')
    end
  end

  context 'Strip Special Characters' do

    context 'Strip &' do

      it 'should replace & with &38;' do
        Cumber.strip_special_chars('&&').should eql('&38;&38;')
      end

    end

    context 'Strip [' do

      it 'should replace [ with &91;' do
        Cumber.strip_special_chars('[[').should eql('&91;&91;')
      end

    end

    context 'Strip ]' do

      it 'should replace ] with &93;' do
        Cumber.strip_special_chars(']]').should eql('&93;&93;')
      end

    end

    context 'Strip "' do

      it 'should replace " with &34;' do
        Cumber.strip_special_chars('"Test"').should eql('&34;Test&34;')
      end

    end

    context 'Strip blank space' do

      it 'should replace the empty space with &32;' do
        Cumber.strip_special_chars('Test A').should eql('Test&32;A')
      end

    end

    context 'Strip {' do

      it 'should replace { with &123;' do
        Cumber.strip_special_chars('{{').should eql('&123;&123;')
      end

    end

    context 'Strip }' do

      it 'should replace } with &125;' do
        Cumber.strip_special_chars('}}').should eql('&125;&125;')
      end

    end

    context 'Strip Multiple characters' do

      it 'should replace all instance of the special characters' do

        input_string = 'target.frontMostApp().mainWindow().scrollViews()[0].webViews()[0].secureTextFields()["Password"].tap(); while(target.frontMostApp().keyboard().checkIsValid() == false) {}; target.frontMostApp().keyboard().typeString("pas&word");'
        expected = 'target.frontMostApp().mainWindow().scrollViews()&91;0&93;.webViews()&91;0&93;.secureTextFields()&91;&34;Password&34;&93;.tap();&32;while(target.frontMostApp().keyboard().checkIsValid()&32;==&32;false)&32;&123;&125;;&32;target.frontMostApp().keyboard().typeString(&34;pas&38;word&34;);'
        Cumber.strip_special_chars(input_string).should eql(expected)
      end
    end

  end

  context 'Format command' do

    it 'should convert the command to Json structure' do
      command = 'target.frontMostApp().keyboard().typeString("pas&word");'

      Cumber.format_command(command).should eql('{"message":"target.frontMostApp().keyboard().typeString(&34;pas&38;word&34;);"}')
    end
  end

  #context 'Send Command to the server' do
  #
  #  it 'should send the command and get a response' do
  #   false
  #  end
  #
  #end

end

