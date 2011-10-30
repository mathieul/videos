require 'spec_helper'

describe "Video Model" do
  let(:video) { Video.new }
  it 'can be created' do
    video.should_not be_nil
  end
end
