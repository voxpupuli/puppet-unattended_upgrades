require 'spec_helper'

describe 'unattended_upgrades' do
  let(:file_unattended) { '/etc/apt/apt.conf.d/50unattended-upgrades' }
  let(:file_periodic) { '/etc/apt/apt.conf.d/10periodic' }
  let(:facts) { {
    :osfamily => 'Debian',
    :lsbdistid => 'Debian',
    :lsbistcodename => 'wheezy',
    :lsbrelease => '7.0.3',
  } }

  it { should contain_package("unattended-upgrades") }

  it { should contain_apt__conf('unattended-upgrades').with({
      "require" => "Package[unattended-upgrades]",
  })
  }

  it { should contain_apt__conf('periodic').with({
      "require" => "Package[unattended-upgrades]",
  })
  }

  it {
    should create_file(file_unattended).with({
      "owner"   => "root",
      "group"   => "root",
      "mode"    => "0644",
    })
  }

  it {
    should create_file(file_periodic).with({
      "owner"   => "root",
      "group"   => "root",
      "mode"    => "0644",
    })
  }
end
