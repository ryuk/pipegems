require 'spec_helper'

describe VersionDecorator do
  before { ApplicationController.new.set_current_view_context }

  subject { VersionDecorator.new version }
  let(:version) { Fabricate.build :version }

  context '#name_with_prefix' do
    it 'should add `v`' do
      subject.name_with_prefix.should eql "v#{version.name}"
    end
  end

end
