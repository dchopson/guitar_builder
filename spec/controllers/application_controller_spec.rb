require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do
  describe '#configure_permitted_parameters' do
    it 'is covered' do
      allow(subject).to receive(:resource_class) { double(:resource_class, authentication_keys: []) }
      allow(subject).to receive(:resource_name) { double(:resource_name) }
      subject.send(:configure_permitted_parameters)
    end
  end
end
