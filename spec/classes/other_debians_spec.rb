require 'spec_helper'
describe 'unattended_upgrades' do
  let(:file_unattended) { '/etc/apt/apt.conf.d/50unattended-upgrades' }
  let(:file_periodic) { '/etc/apt/apt.conf.d/10periodic' }
  let(:file_options) { '/etc/apt/apt.conf.d/10options' }

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
        group: 'root',
        mode: '0644'
      )
    end
  end

  context 'with defaults on Linux Mint 13 Maya' do
    let(:facts) do
      {
        os: {
          name: 'LinuxMint',
          family: 'Debian',
          release: {
            full: '13'
          }
        },
        osfamily: 'Debian',
        lsbdistid: 'LinuxMint',
        lsbdistcodename: 'maya',
        lsbdistrelease: '13',
        lsbmajdistrelease: '13'
      }
    end

    it do
      is_expected.to create_file(file_unattended).with(
        'owner' => 'root',
        'group' => 'root',
        'mode'  => '0644'
      ).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        %r{\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"Ubuntu\:precise-security";\n
        };}x
      )
    end
  end

  context 'with defaults on Linux Mint 17.3 Rosa' do
    let(:facts) do
      {
        os: {
          name: 'LinuxMint',
          family: 'Debian',
          release: {
            full: '17.3'
          }
        },
        osfamily: 'Debian',
        lsbdistid: 'LinuxMint',
        lsbdistcodename: 'rosa',
        lsbdistrelease: '17.3',
        lsbmajdistrelease: '17'
      }
    end

    it do
      is_expected.to create_file(file_unattended).with(
        'owner' => 'root',
        'group' => 'root',
        'mode'  => '0644'
      ).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        %r{\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"Ubuntu\:trusty-security";\n
        };}x
      )
    end
  end

  context 'with defaults on Linux Mint 18 Sarah' do
    let(:facts) do
      {
        os: {
          name: 'LinuxMint',
          family: 'Debian',
          release: {
            full: '18'
          }
        },
        osfamily: 'Debian',
        lsbdistid: 'LinuxMint',
        lsbdistcodename: 'sarah',
        lsbdistrelease: '18',
        lsbmajdistrelease: '18'
      }
    end

    it do
      is_expected.to create_file(file_unattended).with(
        'owner' => 'root',
        'group' => 'root',
        'mode'  => '0644'
      ).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        %r{\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"Ubuntu\:xenial-security";\n
        };}x
      )
    end
  end
end
