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
  let(:pre_condition) {
    'include ::apt'
  }

  context 'with defaults on Debian' do
    it { should contain_package('unattended-upgrades') }

    it { should contain_apt__conf('unattended-upgrades').with({
      'require' => 'Package[unattended-upgrades]',
    })
    }

    it { should contain_apt__conf('periodic').with({
      'require' => 'Package[unattended-upgrades]',
    })
    }

    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        /Unattended-Upgrade::Origins-Pattern {/
      ).with_content(
        /Unattended-Upgrade::Package-Blacklist {\n};/
      ).with_content(
        /Unattended-Upgrade::AutoFixInterruptedDpkg "true";/
      ).with_content(
        /Unattended-Upgrade::MinimalSteps "true";/
      ).with_content(
        /Unattended-Upgrade::InstallOnShutdown "false";/
      ).with_content(
        /Unattended-Upgrade::Remove-Unused-Dependencies "true";/
      ).with_content(
        /Unattended-Upgrade::Automatic-Reboot "false";/
      ).without_content(
        /Unattended-Upgrade::Mail/
      ).without_content(
        /Unattended-Upgrade::MailOnlyOnError/
      ).without_content(
        /Acquire::http::Dl-Limit/
      )
    }

    it {
      should create_file(file_periodic).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        /APT::Periodic::Enable "1";/
      ).with_content(
        /APT::Periodic::BackupArchiveInterval "0";/
      ).with_content(
        /APT::Periodic::BackupLevel "3";/
      ).with_content(
        /APT::Periodic::MaxAge "0";/
      ).with_content(
        /APT::Periodic::MinAge "2";/
      ).with_content(
        /APT::Periodic::MaxSize "0";/
      ).with_content(
        /APT::Periodic::Update-Package-Lists "1";/
      ).with_content(
        /APT::Periodic::Download-Upgradeable-Packages "0";/
      ).with_content(
        /APT::Periodic::Download-Upgradeable-Packages-Debdelta "1";/
      ).with_content(
        /APT::Periodic::Unattended-Upgrade "1";/
      ).with_content(
        /APT::Periodic::AutocleanInterval "0";/
      ).with_content(
        /APT::Periodic::Verbose "0";/
      )
    }

    it { should contain_apt__conf('auto-upgrades').with({
      'ensure' => 'absent',
    })
    }
  end

  context 'with defaults on ubuntu' do
    let(:facts) { {
      :osfamily => 'Debian',
      :lsbdistid => 'Ubuntu',
      :lsbistcodename => 'truste',
      :lsbrelease => '14.04',
    } }
    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        # This is the only line that's different for Ubuntu compared to Debian
        /Unattended-Upgrade::Allowed-Origins {/
      )}
  end

  context 'set all the things' do
    let :params do
      {
        :age                  => { 'min' => 1, 'max' => 20 },
        :size                 => 1000,
        :update               => 5,
        :upgradeable_packages => {
          'download_only' => 5,
          'debdelta'      => 5,
        },
        :upgrade              => 5,
        :auto                 => {
          'clean'                => '5',
          'fix_interrupted_dpkg' => false,
          'remove'               => false,
          'reboot'               => true,
        },
        :verbose              => 1,
        :legacy_origin        => true,
        :origins              => [ 'bananas' ],
        :blacklist            => [ 'foo', 'bar' ],
        :minimal_steps        => false,
        :install_on_shutdown  => true,
        :mail                 => {
          'to'            => 'root@localhost',
          'only_on_error' => true,
        },
        :dl_limit             => 70,
      }
    end
    it { should contain_package('unattended-upgrades') }

    it { should contain_apt__conf('unattended-upgrades').with({
      'require' => 'Package[unattended-upgrades]',
    })
    }

    it { should contain_apt__conf('periodic').with({
      'require' => 'Package[unattended-upgrades]',
    })
    }

    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        /Unattended-Upgrade::Allowed-Origins {\n\t"bananas";\n};/
      ).with_content(
        /Unattended-Upgrade::Package-Blacklist {\n\t"foo";\n\t"bar";\n};/
      ).with_content(
        /Unattended-Upgrade::AutoFixInterruptedDpkg "false";/
      ).with_content(
        /Unattended-Upgrade::MinimalSteps "false";/
      ).with_content(
        /Unattended-Upgrade::InstallOnShutdown "true";/
      ).with_content(
        /Unattended-Upgrade::Remove-Unused-Dependencies "false";/
      ).with_content(
        /Unattended-Upgrade::Automatic-Reboot "true";/
      ).with_content(
        /Unattended-Upgrade::Mail "root@localhost";/
      ).with_content(
        /Unattended-Upgrade::MailOnlyOnError "true";/
      ).with_content(
        /Acquire::http::Dl-Limit "70";/
      )
    }

    it {
      should create_file(file_periodic).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        /APT::Periodic::Enable "1";/
      ).with_content(
        /APT::Periodic::BackupArchiveInterval "0";/
      ).with_content(
        /APT::Periodic::BackupLevel "3";/
      ).with_content(
        /APT::Periodic::MaxAge "20";/
      ).with_content(
        /APT::Periodic::MinAge "1";/
      ).with_content(
        /APT::Periodic::MaxSize "1000";/
      ).with_content(
        /APT::Periodic::Update-Package-Lists "5";/
      ).with_content(
        /APT::Periodic::Download-Upgradeable-Packages "5";/
      ).with_content(
        /APT::Periodic::Download-Upgradeable-Packages-Debdelta "5";/
      ).with_content(
        /APT::Periodic::Unattended-Upgrade "5";/
      ).with_content(
        /APT::Periodic::AutocleanInterval "5";/
      ).with_content(
        /APT::Periodic::Verbose "1";/
      )
    }

    it { should contain_apt__conf('auto-upgrades').with({
      'ensure' => 'absent',
    })
    }

  end

  describe 'validation tests' do
    context 'bad install_on_shutdown' do
      let :params do
        {
          :install_on_shutdown => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad legacy_origin' do
      let :params do
        {
          :legacy_origin => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad minimal_steps' do
      let :params do
        {
          :minimal_steps => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad blacklist' do
      let :params do
        {
          :blacklist => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not an Array/)
      end
    end
    context 'bad origins' do
      let :params do
        {
          :origins => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not an Array/)
      end
    end
    context 'bad auto' do
      let :params do
        {
          :auto => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad mail' do
      let :params do
        {
          :mail => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad backup' do
      let :params do
        {
          :backup => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad age' do
      let :params do
        {
          :age => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad size' do
      let :params do
        {
          :size => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /to be an Integer/)
      end
    end
    context 'bad upgradeable_packages' do
      let :params do
        {
          :upgradeable_packages => 'foo',
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad mail[\'only_on_error\']' do
      let :params do
        {
          :mail => { 'only_on_error' => 'foo' },
        }
      end
      it do
        expect {
          subject.call
        }.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
  end
end
