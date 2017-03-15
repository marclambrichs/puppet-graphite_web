require 'spec_helper'
describe 'graphite_web' do
  context 'with default values for all parameters' do
    it { should contain_class('graphite_web') }
  end
end
