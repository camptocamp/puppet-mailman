require 'spec_helper'

describe 'mailman' do

  let(:params) do
    {
      :mailman_password => 'foo',
    }
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { should compile.with_all_deps }
    end
  end
end
