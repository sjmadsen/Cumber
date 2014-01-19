require_relative '../spec_helper'

describe 'String to boolean' do

  it 'should convert true to boolean true' do
     'true'.to_bool.should == true
  end

  it 'should convert True to boolean true' do
    'True'.to_bool.should == true
  end

  it 'should convert 1 to boolean true' do
    '1'.to_bool.should == true
  end

  it 'should convert false to boolean false' do
    'false'.to_bool.should == false
  end

  it 'should convert False to boolean false' do
    'False'.to_bool.should == false
  end

  it 'should convert 0 to boolean false' do
    '0'.to_bool.should == false
  end

end