require 'rails_helper'

RSpec.describe ApplicationHelper, :type => :helper do
  describe '#title' do
    let(:title) { 'hello' }
    
    it 'sets the content for title' do
      helper.title(title)
      expect(helper.content_for(:title)).to eq title
    end
  end
end
