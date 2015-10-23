require 'spec_helper'

describe 'unattended_upgrades' do
  let(:file_unattended) { '/etc/apt/apt.conf.d/50unattended-upgrades' }
  let(:file_periodic) { '/etc/apt/apt.conf.d/10periodic' }
  let(:facts) { {
    :osfamily => 'Debian',
    :lsbdistid => 'Debian',
    :lsbdistcodename => 'wheezy',
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
      ).with_content(
	/APT::Periodic::RandomSleep "1800";/
      )
    }

    it { should contain_apt__conf('auto-upgrades').with({
      'ensure' => 'absent',
    })
    }
  end

  context 'with defaults on Debian 6 Squeeze' do
    let(:facts) { {
      :osfamily => 'Debian',
      :lsbdistid => 'Debian',
      :lsbdistcodename => 'squeeze',
      :lsbdistrelease => '6.0.10',
    } }
    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        # This section varies for different releases
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\ oldoldstable";\n
        \t"\${distro_id}\ \${distro_codename}-security";\n
        \t"\${distro_id}\ \${distro_codename}-lts";\n
        };/x
      )}
  end

  context 'with defaults on Debian 7 Wheezy' do
    let(:facts) { {
      :osfamily => 'Debian',
      :lsbdistid => 'Debian',
      :lsbdistcodename => 'wheezy',
      :lsbdistrelease => '7.1',
    } }
    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        # This section varies for different releases
        /\Unattended-Upgrade::Origins-Pattern\ {\n
        \t"origin=Debian,archive=stable,label=Debian-Security";\n
        \t"origin=Debian,archive=oldstable,label=Debian-Security";\n
        };/x
      )}
  end

  context 'with defaults on Debian 8 Jessie' do
    let(:facts) { {
      :osfamily => 'Debian',
      :lsbdistid => 'Debian',
      :lsbdistcodename => 'jessie',
      :lsbdistrelease => '8.2',
    } }
    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        # This section varies for different releases
        /\Unattended-Upgrade::Origins-Pattern\ {\n
        \t"origin=Debian,codename=\${distro_codename},label=Debian-Security";\n
        };/x
      )}
  end

  context 'with defaults on Ubuntu 12.04LTS Precise Pangolin' do
    let(:facts) { {
      :osfamily => 'Debian',
      :lsbdistid => 'Ubuntu',
      :lsbdistcodename => 'precise',
      :lsbrelease => '12.04',
    } }
    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )}
  end

  context 'with defaults on Ubuntu 14.04LTS Trusty Tahr' do
    let(:facts) { {
      :osfamily => 'Debian',
      :lsbdistid => 'Ubuntu',
      :lsbdistcodename => 'trusty',
      :lsbrelease => '14.04',
    } }
    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )}
  end

  context 'with defaults on Ubuntu 15.04 Vivid Vervet' do
    let(:facts) { {
      :osfamily => 'Debian',
      :lsbdistid => 'Ubuntu',
      :lsbdistcodename => 'vivid',
      :lsbrelease => '15.04',
    } }
    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )}
  end

  context 'with defaults on Ubuntu 15.10 Wily Werewolf' do
    let(:facts) { {
      :osfamily => 'Debian',
      :lsbdistid => 'Ubuntu',
      :lsbdistcodename => 'wily',
      :lsbrelease => '15.10',
    } }
    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      }).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )}
  end

  context 'with defaults on Raspbian' do
    let(:facts) { {
      :osfamily => 'Debian',
      :lsbdistid => 'Raspbian',
      :lsbdistcodename => 'jessie',
      :lsbrelease => '8.0',
    } }
    it {
      should create_file(file_unattended).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      })
    }
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
	 :random_sleep         => 1800,
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
      ).with_content(
	/APT::Periodic::RandomSleep "1800";/
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
