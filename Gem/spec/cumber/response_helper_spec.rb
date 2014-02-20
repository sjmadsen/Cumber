require_relative '../spec_helper'

describe 'Process Response Types from CumberServer' do

  context 'Process string response' do

    context 'Status success' do
      it 'should return the string value' do
        result = Cumber::ResponseHelper.process_string_response({'message'=>'item name', 'status'=>'success'})
        result.should == 'item name'
      end
    end

    context 'Status error' do
      it 'should return nil' do
        result = Cumber::ResponseHelper.process_string_response({'message'=>'item name', 'status'=>'error'})
        result.should == nil
      end
    end

  end

  context 'Process boolean response' do

    context 'Status success' do
      it 'should return the boolean true for the value true' do
        result = Cumber::ResponseHelper.process_bool_response({'message'=>'true', 'status'=>'success'})
        result.should == true
      end

      it 'should return the boolean false for the value false' do
        result = Cumber::ResponseHelper.process_bool_response({'message'=>'false', 'status'=>'success'})
        result.should == false
      end
    end

    context 'Status error' do
      it 'should return nil' do
        result = Cumber::ResponseHelper.process_bool_response({'message'=>'', 'status'=>'error'})
        result.should == nil
      end
    end

  end

  context 'Process json response' do

    context 'Status success' do
      it 'should return object hash for the json' do
        result = Cumber::ResponseHelper.process_hash_response({'message'=>"{:x => '123', :y => '11'}", 'status'=>'success'})
        result[:x].should == '123'
        result[:y].should == '11'
      end
    end

    context 'Status error' do
      it 'should return nil' do
        result = Cumber::ResponseHelper.process_hash_response({'message'=>'', 'status'=>'error'})
        result.should == nil
      end
    end

  end

  context 'Process operation response' do

    context 'Status success' do
      it 'should return the boolean true' do
        result = Cumber::ResponseHelper.process_operation_response({'message'=>'', 'status'=>'success'})
        result.should == true
      end
    end

    context 'Status error' do
      it 'should throw an error' do
        lambda{ Cumber::ResponseHelper.process_operation_response({'message'=>'', 'status'=>'error'})}.should raise_error

      end
    end

  end

end