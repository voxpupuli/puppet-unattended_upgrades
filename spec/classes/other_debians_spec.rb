# frozen_string_literal: true

require 'spec_helper'
describe 'unattended_upgrades' do
  let(:file_unattended) { '/etc/apt/apt.conf.d/50unattended-upgrades' }
  let(:file_periodic) { '/etc/apt/apt.conf.d/10periodic' }

  context 'with defaults on Raspbian' do
    let(:facts) do
      {
        os: {
          name: 'Raspbian',
          family: 'Debian',
          release: {
            full: '8.0'
          }
        },
        osfamily: 'Debian',
        lsbdistid: 'Raspbian',
        lsbdistcodename: 'jessie',
        lsbrelease: '8.0'
      }
    end

    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root'
      )
    end
  end
end
