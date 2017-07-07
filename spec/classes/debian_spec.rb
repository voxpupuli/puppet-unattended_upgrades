require 'spec_helper'

# rubocop:disable Style/RegexpLiteral
describe 'unattended_upgrades' do
  let(:file_unattended) { '/etc/apt/apt.conf.d/50unattended-upgrades' }
  let(:file_periodic) { '/etc/apt/apt.conf.d/10periodic' }
  let(:file_options) { '/etc/apt/apt.conf.d/10options' }

  let(:pre_condition) do
    'include ::apt'
  end

  shared_examples 'Debian specs' do
    let(:params) { {} }

    it { is_expected.to compile.with_all_deps }

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

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge(fqdn: 'unattended-upgrades.example.com',
                    path: '/usr/lib64/qt-3.3/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/opt/puppetlabs/bin:/root/bin')
      end

      case facts[:operatingsystem]
      when 'Debian'
        it_behaves_like 'Debian specs'
        case facts[:lsbdistcodename]
        when 'squeeze'
          context 'with defaults on Debian 6 Squeeze' do
            it do
              is_expected.to create_file(file_unattended).with(
                owner: 'root',
                group: 'root',
                mode: '0644'
              ).with_content(
                # This section varies for different releases
                /\Unattended-Upgrade::Allowed-Origins\ {\n
                \t"\${distro_id}\ \${distro_codename}-security";\n
                \t"\${distro_id}\ \${distro_codename}-lts";\n
                };/x
              )
            end
          end
        when 'wheezy'
          context 'with defaults on Debian 7 wheezy' do
            it do
              is_expected.to create_file(file_unattended).with(
                owner: 'root',
                group: 'root',
                mode: '0644'
              ).with_content(
                # This section varies for different releases
                /\Unattended-Upgrade::Origins-Pattern\ {\n
                \t"origin=Debian,archive=oldoldstable,label=Debian-Security";\n
                };/x
              )
            end
          end
        when 'jessie'
          context 'with defaults on Debian 8 Jessie' do
            it do
              is_expected.to create_file(file_unattended).with(
                owner: 'root',
                group: 'root',
                mode: '0644'
              ).with_content(
                # This section varies for different releases
                /\Unattended-Upgrade::Origins-Pattern\ {\n
                \t"origin=Debian,archive=oldstable,label=Debian-Security";\n
                };/x
              )
            end
          end
        end
      when 'stretch'
        context 'with defaults on Debian 9 Stretch' do
          it do
            is_expected.to create_file(file_unattended).with(
              owner: 'root',
              group: 'root',
              mode: '0644'
            ).with_content(
              # This section varies for different releases
              /\Unattended-Upgrade::Origins-Pattern\ {\n
              \t"origin=Debian,archive=oldstable,label=Debian-Security";\n
              };/x
            )
          end
        end
      end
    end
  end
end
