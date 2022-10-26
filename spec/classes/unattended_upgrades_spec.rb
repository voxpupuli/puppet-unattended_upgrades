# frozen_string_literal: true

require 'spec_helper'

describe 'unattended_upgrades' do
  let(:file_unattended) { '/etc/apt/apt.conf.d/50unattended-upgrades' }
  let(:file_periodic) { '/etc/apt/apt.conf.d/10periodic' }

  shared_examples 'basic specs' do
    let(:params) { {} }

    context 'baseline specs' do
      it { is_expected.to compile.with_all_deps }

      it do
        is_expected.to contain_package('unattended-upgrades')
        is_expected.to compile.with_all_deps
        is_expected.to contain_class('unattended_upgrades::params')
        is_expected.to contain_class('unattended_upgrades')
        is_expected.to contain_class('apt')
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

      it { is_expected.to create_file(file_unattended).without_content(%r{Unattended-Upgrade::Sender}) }
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
          days: %w[tuesday Thursday 5],
          auto: {
            'clean'                => 5,
            'fix_interrupted_dpkg' => false,
            'remove'               => false,
            'reboot'               => true,
            'reboot_withusers'     => false,
            'reboot_time'          => '03:00'
          },
          verbose: 1,
          origins: %w[codename=bananas],
          blacklist: %w[foo bar],
          whitelist: %w[foo bar],
          minimal_steps: false,
          install_on_shutdown: true,
          mail: {
            'to'            => 'root@localhost',
            'only_on_error' => true,
            'report'        => 'on-change'
          },
          sender: 'root@server.example.com',
          dl_limit: 70,
          random_sleep: 300,
          notify_update: true,
          remove_new_unused_deps: false,
          syslog_enable: true,
          syslog_facility: 'daemon',
          only_on_ac_power: false,
          whitelist_strict: true,
          allow_downgrade: false,
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
        is_expected.to create_file(file_unattended).with(
          owner: 'root',
          group: 'root'
        ).with_content(
          %r{Unattended-Upgrade::Origins-Pattern {\n\t"codename=bananas";\n};}
        ).with_content(
          %r{Unattended-Upgrade::Package-Blacklist {\n\t"foo";\n\t"bar";\n};}
        ).with_content(
          %r{Unattended-Upgrade::Package-Whitelist {\n\t"foo";\n\t"bar";\n};\n}
        ).with_content(
          %r{Unattended-Upgrade::Package-Whitelist-Strict "true";}
        ).with_content(
          %r{Unattended-Upgrade::Update-Days {\n\t"Tuesday";\n\t"Thursday";\n\t"5";\n};}
        ).with_content(
          %r{Unattended-Upgrade::AutoFixInterruptedDpkg "false";}
        ).with_content(
          %r{Unattended-Upgrade::MinimalSteps "false";}
        ).with_content(
          %r{Unattended-Upgrade::InstallOnShutdown "true";}
        ).with_content(
          %r{Unattended-Upgrade::Remove-Unused-Dependencies "false";}
        ).with_content(
          %r{Unattended-Upgrade::Automatic-Reboot "true";}
        ).with_content(
          %r{Unattended-Upgrade::Automatic-Reboot-WithUsers "false";}
        ).with_content(
          %r{Unattended-Upgrade::Automatic-Reboot-Time "03:00";}
        ).with_content(
          %r{Unattended-Upgrade::Mail "root@localhost";}
        ).with_content(
          %r{Unattended-Upgrade::Sender "root@server.example.com";}
        ).with_content(
          %r{Unattended-Upgrade::MailOnlyOnError "true";}
        ).with_content(
          %r{Unattended-Upgrade::MailReport "on-change";}
        ).with_content(
          %r{Acquire::http::Dl-Limit "70";}
        ).with_content(
          %r{Unattended-Upgrade::Remove-New-Unused-Dependencies "false";}
        ).without_content(
          %r{Unattended-Upgrade::Remove-Unused-Kernel-Packages}
        ).with_content(
          %r{Unattended-Upgrade::SyslogEnable "true";}
        ).with_content(
          %r{Unattended-Upgrade::SyslogFacility "daemon";}
        ).with_content(
          %r{Unattended-Upgrade::OnlyOnACPower "false";}
        ).with_content(
          %r{Unattended-Upgrade::Allow-downgrade "false";}
        )
      end

      it do
        is_expected.to create_file(file_periodic).with(
          owner: 'root',
          group: 'root'
        ).with_content(
          %r{APT::Periodic::Enable "1";}
        ).with_content(
          %r{APT::Periodic::BackupArchiveInterval "0";}
        ).with_content(
          %r{APT::Periodic::BackupLevel "3";}
        ).with_content(
          %r{APT::Periodic::MaxAge "20";}
        ).with_content(
          %r{APT::Periodic::MinAge "1";}
        ).with_content(
          %r{APT::Periodic::MaxSize "1000";}
        ).with_content(
          %r{APT::Periodic::Update-Package-Lists "5";}
        ).with_content(
          %r{APT::Periodic::Download-Upgradeable-Packages "5";}
        ).with_content(
          %r{APT::Periodic::Download-Upgradeable-Packages-Debdelta "5";}
        ).with_content(
          %r{APT::Periodic::Unattended-Upgrade "5";}
        ).with_content(
          %r{APT::Periodic::AutocleanInterval "5";}
        ).with_content(
          %r{APT::Periodic::Verbose "1";}
        ).with_content(
          %r{APT::Periodic::RandomSleep "300";}
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

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad days' do
        let :params do
          {
            days: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad minimal_steps' do
        let :params do
          {
            minimal_steps: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad blacklist' do
        let :params do
          {
            blacklist: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad origins' do
        let :params do
          {
            origins: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad auto' do
        let :params do
          {
            auto: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad mail' do
        let :params do
          {
            mail: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad backup' do
        let :params do
          {
            backup: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad age' do
        let :params do
          {
            age: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad size' do
        let :params do
          {
            size: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad upgradeable_packages' do
        let :params do
          {
            upgradeable_packages: 'foo'
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end

      context 'bad mail[\'only_on_error\']' do
        let :params do
          {
            mail: { 'only_on_error' => 'foo' }
          }
        end

        it { is_expected.to compile.and_raise_error(%r{got String}) }
      end
    end

    describe 'n-days settings tests' do
      context 'update supports always' do
        let :params do
          {
            update: 'always'
          }
        end

        it do
          is_expected.to create_file(file_periodic).with_content(
            %r{APT::Periodic::Update-Package-Lists "always";}
          )
        end
      end

      context 'ugrade supports always' do
        let :params do
          {
            upgrade: 'always'
          }
        end

        it do
          is_expected.to create_file(file_periodic).with_content(
            %r{APT::Periodic::Unattended-Upgrade "always";}
          )
        end
      end

      context 'count supports always' do
        let :params do
          {
            auto: { 'clean' => 'always' }
          }
        end

        it do
          is_expected.to create_file(file_periodic).with_content(
            %r{APT::Periodic::AutocleanInterval "always";}
          )
        end
      end

      context 'download-only supports always' do
        let :params do
          {
            upgradeable_packages: { 'download_only' => 'always' }
          }
        end

        it do
          is_expected.to create_file(file_periodic).with_content(
            %r{APT::Periodic::Download-Upgradeable-Packages "always";}
          )
        end
      end
    end
  end

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(fqdn: 'unattended-upgrades.example.com',
                    path: '/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin')
      end

      it_behaves_like 'basic specs'
    end
  end
end
