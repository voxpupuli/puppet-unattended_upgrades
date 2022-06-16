# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'unattended_upgrades with default settings' do
  context 'with default parameters' do
    let(:manifest) { 'include unattended_upgrades' }

    it_behaves_like 'an idempotent resource'
  end
end
