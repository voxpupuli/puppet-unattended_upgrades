require 'spec_helper'

# rubocop:disable Style/RegexpLiteral
describe 'unattended_upgrades' do
  let(:file_unattended) { '/etc/apt/apt.conf.d/50unattended-upgrades' }
  let(:file_periodic) { '/etc/apt/apt.conf.d/10periodic' }
  let(:file_options) { '/etc/apt/apt.conf.d/10options' }

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

      it do
        is_expected.to contain_apt__conf('options').with(
          require: 'Package[unattended-upgrades]',
          notify_update: false
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
            'clean'                => 5,
            'fix_interrupted_dpkg' => false,
            'remove'               => false,
            'reboot'               => true,
            'reboot_time'          => '03:00'
          },
          verbose: 1,
          legacy_origin: true,
          origins: %w[bananas],
          blacklist: %w[foo bar],
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /got String/)
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
          end.to raise_error(Puppet::Error, /unrecognized key 'invalid_key'/)
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
