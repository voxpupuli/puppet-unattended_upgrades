require 'spec_helper'

# rubocop:disable Style/RegexpLiteral
describe 'unattended_upgrades' do
  let(:file_unattended) { '/etc/apt/apt.conf.d/50unattended-upgrades' }
  let(:file_periodic) { '/etc/apt/apt.conf.d/10periodic' }
  let(:file_options) { '/etc/apt/apt.conf.d/10options' }
  let(:facts) do
    {
      osfamily: 'Debian',
      lsbdistid: 'Debian',
      lsbdistcodename: 'wheezy',
      lsbrelease: '7.0.3'
    }
  end
  let(:pre_condition) do
    'include ::apt'
  end

  context 'with defaults on Debian' do
    it do
      is_expected.to contain_package('unattended-upgrades')
      is_expected.to compile.with_all_deps
      is_expected.to contain_class('unattended_upgrades::params')
      is_expected.to contain_class('unattended_upgrades')
    end

    it do
      is_expected.to contain_apt__conf('unattended-upgrades').with(
        require: 'Package[unattended-upgrades]',
        notify_update: false
      )
    end

    it do
      is_expected.to contain_apt__conf('periodic').with(
        require: 'Package[unattended-upgrades]',
        notify_update: false
      )
    end

    it do
      is_expected.to contain_apt__conf('options').with(
        require: 'Package[unattended-upgrades]',
        notify_update: false
      )
    end

    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
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
      ).with_content(
        /Unattended-Upgrade::Automatic-Reboot-Time "now";/
      ).without_content(
        /Unattended-Upgrade::Mail/
      ).without_content(
        /Unattended-Upgrade::MailOnlyOnError/
      ).without_content(
        /Acquire::http::Dl-Limit/
      )
    end

    it do
      is_expected.to create_file(file_periodic).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
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
    end

    it do
      is_expected.to contain_apt__conf('auto-upgrades').with(
        ensure: 'absent'
      )
    end
    it do
      is_expected.to create_file(file_options).with(
        owner: 'root',
        group: 'root',
        mode:  '0644'
      ).with_content(
        /^Dpkg::Options\s{/
      ).with_content(
        /^\s+\"--force-confdef\";/
      ).with_content(
        /^\s+\"--force-confold\";/
      ).without_content(
        /\"--force-confnew\";/
      ).without_content(
        /\"--force-confmiss\";/
      )
    end
  end

  context 'with defaults on Debian 6 Squeeze' do
    let(:facts) do
      {
        osfamily: 'Debian',
        lsbdistid: 'Debian',
        lsbdistcodename: 'squeeze',
        lsbdistrelease: '6.0.10'
      }
    end
    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
        # This section varies for different releases
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\ oldoldstable";\n
        \t"\${distro_id}\ \${distro_codename}-security";\n
        \t"\${distro_id}\ \${distro_codename}-lts";\n
        };/x
      )
    end
  end

  context 'with defaults on Debian 7 Wheezy' do
    let(:facts) do
      {
        osfamily: 'Debian',
        lsbdistid: 'Debian',
        lsbdistcodename: 'wheezy',
        lsbdistrelease: '7.1'
      }
    end
    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
        # This section varies for different releases
        /\Unattended-Upgrade::Origins-Pattern\ {\n
        \t"origin=Debian,archive=stable,label=Debian-Security";\n
        \t"origin=Debian,archive=oldstable,label=Debian-Security";\n
        };/x
      )
    end
  end

  context 'with defaults on Debian 8 Jessie' do
    let(:facts) do
      {
        osfamily: 'Debian',
        lsbdistid: 'Debian',
        lsbdistcodename: 'jessie',
        lsbdistrelease: '8.2'
      }
    end
    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
        # This section varies for different releases
        /\Unattended-Upgrade::Origins-Pattern\ {\n
        \t"origin=Debian,codename=\${distro_codename},label=Debian-Security";\n
        };/x
      )
    end
  end

  context 'with defaults on Ubuntu 12.04LTS Precise Pangolin' do
    let(:facts) do
      {
        osfamily: 'Debian',
        lsbdistid: 'Ubuntu',
        lsbdistcodename: 'precise',
        lsbdistrelease: '12.04'
      }
    end
    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )
    end
  end

  context 'with defaults on Ubuntu 14.04LTS Trusty Tahr' do
    let(:facts) do
      {
        osfamily: 'Debian',
        lsbdistid: 'Ubuntu',
        lsbdistcodename: 'trusty',
        lsbdistrelease: '14.04'
      }
    end
    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )
    end
  end

  context 'with defaults on Ubuntu 15.04 Vivid Vervet' do
    let(:facts) do
      {
        osfamily: 'Debian',
        lsbdistid: 'Ubuntu',
        lsbdistcodename: 'vivid',
        lsbdistrelease: '15.04'
      }
    end
    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )
    end
    # TODO: implement test case for "warning", similar to
    # w = 'Ubuntu 15.04 "vivid" has reached End of Life - please upgrade!'
    # it_behaves_like 'has_warning', pp, w
  end

  context 'with defaults on Ubuntu 15.10 Wily Werewolf' do
    let(:facts) do
      {
        osfamily: 'Debian',
        lsbdistid: 'Ubuntu',
        lsbdistcodename: 'wily',
        lsbdistrelease: '15.10'
      }
    end
    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )
    end
  end

  context 'with defaults on Ubuntu 16.04 Xenial Xerus' do
    let(:facts) do
      {
        osfamily: 'Debian',
        lsbdistid: 'Ubuntu',
        lsbdistcodename: 'xenial',
        lsbdistrelease: '16.04'
      }
    end
    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}";\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )
    end
  end

  context 'with defaults on Ubuntu 16.10 Yakkety Yak' do
    let(:facts) do
      {
        osfamily: 'Debian',
        lsbdistid: 'Ubuntu',
        lsbdistcodename: 'yakkety',
        lsbdistrelease: '16.10'
      }
    end
    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
        # This is the only section that's different for Ubuntu compared to Debian
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"\${distro_id}\:\${distro_codename}";\n
        \t"\${distro_id}\:\${distro_codename}-security";\n
        };/x
      )
    end
  end

  context 'with defaults on Raspbian' do
    let(:facts) do
      {
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
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"Ubuntu\:precise-security";\n
        };/x
      )
    end
  end

  context 'with defaults on Linux Mint 17.3 Rosa' do
    let(:facts) do
      {
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
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"Ubuntu\:trusty-security";\n
        };/x
      )
    end
  end

  context 'with defaults on Linux Mint 18 Sarah' do
    let(:facts) do
      {
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
        /\Unattended-Upgrade::Allowed-Origins\ {\n
        \t"Ubuntu\:xenial-security";\n
        };/x
      )
    end
  end

  context 'set all the things' do
    let :params do
      {
        age: { 'min' => 1, 'max' => 20 },
        size: 1000,
        update: 5,
        upgradeable_packages: {
          'download_only' => 5,
          'debdelta'      => 5
        },
        upgrade: 5,
        auto: {
          'clean'                => '5',
          'fix_interrupted_dpkg' => false,
          'remove'               => false,
          'reboot'               => true,
          'reboot_time'          => '03:00'
        },
        verbose: 1,
        legacy_origin: true,
        origins: %w(bananas),
        blacklist: %w(foo bar),
        minimal_steps: false,
        install_on_shutdown: true,
        mail: {
          'to'            => 'root@localhost',
          'only_on_error' => true
        },
        dl_limit: 70,
        random_sleep: 300,
        notify_update: true,
        options: {
          'force_confdef' =>  false,
          'force_confold' =>  false,
          'force_confnew' =>  true,
          'force_confmiss' => true
        }
      }
    end
    it { is_expected.to contain_package('unattended-upgrades') }

    it do
      is_expected.to contain_apt__conf('unattended-upgrades').with(
        require: 'Package[unattended-upgrades]',
        notify_update: true
      )
    end

    it do
      is_expected.to contain_apt__conf('periodic').with(
        require: 'Package[unattended-upgrades]',
        notify_update: true
      )
    end

    it do
      is_expected.to contain_apt__conf('options').with(
        require: 'Package[unattended-upgrades]',
        notify_update: true
      )
    end

    it do
      is_expected.to create_file(file_unattended).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
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
        /Unattended-Upgrade::Automatic-Reboot-Time "03:00";/
      ).with_content(
        /Unattended-Upgrade::Mail "root@localhost";/
      ).with_content(
        /Unattended-Upgrade::MailOnlyOnError "true";/
      ).with_content(
        /Acquire::http::Dl-Limit "70";/
      )
    end

    it do
      is_expected.to create_file(file_periodic).with(
        owner: 'root',
        group: 'root',
        mode: '0644'
      ).with_content(
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
        /APT::Periodic::RandomSleep "300";/
      )
    end

    it do
      is_expected.to create_file(file_options).with(
        owner: 'root',
        group: 'root',
        mode:  '0644'
      ).with_content(
        /^Dpkg::Options\s{/
      ).without_content(
        /"--force-confdef";/
      ).without_content(
        /"--force-confold";/
      ).with_content(
        /^\s+"--force-confnew";/
      ).with_content(
        /^\s+"--force-confmiss";/
      )
    end
    it do
      is_expected.to contain_apt__conf('auto-upgrades').with(
        ensure: 'absent'
      )
    end
  end

  describe 'validation tests' do
    context 'bad install_on_shutdown' do
      let :params do
        {
          install_on_shutdown: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad legacy_origin' do
      let :params do
        {
          legacy_origin: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad minimal_steps' do
      let :params do
        {
          minimal_steps: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad blacklist' do
      let :params do
        {
          blacklist: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not an Array/)
      end
    end
    context 'bad origins' do
      let :params do
        {
          origins: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not an Array/)
      end
    end
    context 'bad auto' do
      let :params do
        {
          auto: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad mail' do
      let :params do
        {
          mail: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad backup' do
      let :params do
        {
          backup: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad age' do
      let :params do
        {
          age: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad size' do
      let :params do
        {
          size: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /to be an Integer/)
      end
    end
    context 'bad upgradeable_packages' do
      let :params do
        {
          upgradeable_packages: 'foo'
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a Hash/)
      end
    end
    context 'bad mail[\'only_on_error\']' do
      let :params do
        {
          mail: { 'only_on_error' => 'foo' }
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad options[\'force_confdef\']' do
      let :params do
        {
          options: { 'force_confdef' => 'foo' }
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad options[\'force_confold\']' do
      let :params do
        {
          options: { 'force_confold' => 'foo' }
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad options[\'force_confnew\']' do
      let :params do
        {
          options: { 'force_confnew' => 'foo' }
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad options[\'force_confmiss\']' do
      let :params do
        {
          options: { 'force_confmiss' => 'foo' }
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /not a boolean/)
      end
    end
    context 'bad options[\'invalid_key\']' do
      let :params do
        {
          options: { 'invalid_key' => true }
        }
      end
      it do
        expect do
          subject.call
        end.to raise_error(Puppet::Error, /invalid_key not a valid key/)
      end
    end
  end
end
