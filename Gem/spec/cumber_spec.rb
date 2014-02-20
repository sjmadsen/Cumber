require 'spec_helper.rb'
require 'net/http'

describe Cumber do

  context 'Execute Cucumber step' do

    it 'should send the command to server and return the response' do

      step = 'target.frontMostApp().keyboard().typeString("pas&word");'
      Cumber.should_receive(:send_command).with(step, 'run').and_return('{"message":"result", "status":"success"}')
      Cumber.execute_step(step).should eql('message' => 'result', 'status' => 'success')
    end
  end

  context 'Strip Special Characters' do

    context 'Strip "' do

      it 'should replace " with \"' do
        Cumber.strip_special_chars('"Test"').should eql('\"Test\"')
      end

    end

    context 'Strip \'' do

      it 'should replace \' with \' ' do
        Cumber.strip_special_chars("'Test'").should eql("\\'Test\\'")
      end

    end

  end

  context 'Format command' do

    it 'should convert the command to Json structure' do
      command = 'target.frontMostApp().keyboard().typeString("pas&word");'

      Cumber.format_command(command, 'run').should eql('{"message":"target.frontMostApp().keyboard().typeString(\"pas&word\");", "status":"run"}')
    end
  end

  context 'Send Command to the server' do

    it 'should send the command and get a response' do

      command = 'target.frontMostApp().keyboard().typeString("pass&word");'

      http = double :http
      mock_request = double :mock_request
      mock_response = double :mock_response

      mock_request.stub(:body).and_return('')
      mock_request.should_receive(:body=).with('{"message":"target.frontMostApp().keyboard().typeString(\"pass&word\");", "status":"run"}')

      Net::HTTP::Post.stub(:new).and_return(mock_request)
      Net::HTTP.stub(:start).and_yield http

      http.should_receive(:request).with(mock_request).and_return mock_response

      mock_response.should_receive(:body).and_return('{"message":"test", "status":"success"}')

      Cumber.send_command(command, 'run').should eql '{"message":"test", "status":"success"}'
    end

  end

end

