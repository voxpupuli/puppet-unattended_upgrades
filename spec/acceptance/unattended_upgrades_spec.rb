# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'unattended_upgrades' do
  let(:distro_id) { fact('os.name') }
  let(:codename) { fact('os.distro.codename') }

  context 'with default parameters' do
    let(:manifest) { 'include unattended_upgrades' }

    it_behaves_like 'an idempotent resource'

    describe package('unattended-upgrades') do
      it { is_expected.to be_installed }
    end

    describe service('unattended-upgrades') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe file('/etc/apt/apt.conf.d/50unattended-upgrades') do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'root' }
      it { is_expected.to be_mode 644 }
      it { is_expected.to contain 'Unattended-Upgrade::Remove-Unused-Dependencies "true";' }
      it { is_expected.to contain 'Unattended-Upgrade::Automatic-Reboot "false";' }
      it { is_expected.to contain 'Unattended-Upgrade::Automatic-Reboot-Time "now";' }
      it { is_expected.not_to contain 'Unattended-Upgrade::Remove-Unused-Kernel-Packages' }
      it { is_expected.not_to contain 'Unattended-Upgrade::Remove-New-Unused-Dependencies' }
      it { is_expected.not_to contain 'Unattended-Upgrade::OnlyOnACPower' }

      if fact('os.name') == 'Ubuntu'
        it { is_expected.to contain '"origin=${distro_id},suite=${distro_codename}-security";' }
        it { is_expected.to contain '"origin=${distro_id}ESM,suite=${distro_codename}-infra-security";' }
      else
        it { is_expected.to contain '"origin=Debian,codename=${distro_codename}-security,label=Debian-Security";' }
      end
    end

    describe file('/etc/apt/apt.conf.d/10periodic') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'APT::Periodic::Enable "1";' }
      it { is_expected.to contain 'APT::Periodic::Update-Package-Lists "1";' }
      it { is_expected.to contain 'APT::Periodic::Unattended-Upgrade "1";' }
      it { is_expected.to contain 'APT::Periodic::AutocleanInterval "0";' }
    end

    # created by the package's postinst; it would override 10periodic
    describe file('/etc/apt/apt.conf.d/20auto-upgrades') do
      it { is_expected.not_to exist }
    end

    describe command('apt-config dump') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match %r{^APT::Periodic::Update-Package-Lists "1";$} }
      its(:stdout) { is_expected.to match %r{^APT::Periodic::Unattended-Upgrade "1";$} }
      its(:stdout) { is_expected.to match %r{^Unattended-Upgrade::Automatic-Reboot "false";$} }
    end

    # exit status is not checked: --dry-run still downloads pending upgrades,
    # so it depends on mirror state rather than this module
    describe command('unattended-upgrade --dry-run --debug') do
      it 'expands the configured origins' do
        expected = if distro_id == 'Ubuntu'
                     "origin=Ubuntu,suite=#{codename}-security"
                   else
                     "origin=Debian,codename=#{codename}-security,label=Debian-Security"
                   end
        expect(subject.stdout).to match %r{^Allowed origins are:.*\b#{Regexp.escape(expected)}\b}
      end
    end
  end

  context 'with non-default parameters' do
    let(:manifest) do
      <<~PUPPET
        class { 'unattended_upgrades':
          origins                => [
            'origin=${distro_id},suite=${distro_codename}-security',
            'origin=Example,codename=stable',
          ],
          # blacklist everything so the dry run below downloads nothing
          blacklist              => ['.*'],
          auto                   => {
            'clean'       => 'always',
            'remove'      => false,
            'reboot'      => true,
            'reboot_time' => '02:00',
          },
          update                 => 'always',
          upgrade                => '12h',
          remove_unused_kernel   => true,
          remove_new_unused_deps => false,
          only_on_ac_power       => false,
          service_ensure         => 'stopped',
          service_enable         => false,
        }
      PUPPET
    end

    it_behaves_like 'an idempotent resource'

    describe service('unattended-upgrades') do
      it { is_expected.not_to be_enabled }
      it { is_expected.not_to be_running }
    end

    describe file('/etc/apt/apt.conf.d/50unattended-upgrades') do
      it { is_expected.to be_file }
      it { is_expected.to contain '"origin=${distro_id},suite=${distro_codename}-security";' }
      it { is_expected.to contain '"origin=Example,codename=stable";' }
      it { is_expected.not_to contain '"origin=${distro_id},suite=${distro_codename}";' }
      it { is_expected.to contain '".*";' }
      it { is_expected.to contain 'Unattended-Upgrade::Remove-Unused-Dependencies "false";' }
      it { is_expected.to contain 'Unattended-Upgrade::Automatic-Reboot "true";' }
      it { is_expected.to contain 'Unattended-Upgrade::Automatic-Reboot-Time "02:00";' }
      it { is_expected.to contain 'Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";' }
      it { is_expected.to contain 'Unattended-Upgrade::Remove-New-Unused-Dependencies "false";' }
      it { is_expected.to contain 'Unattended-Upgrade::OnlyOnACPower "false";' }
    end

    describe file('/etc/apt/apt.conf.d/10periodic') do
      it { is_expected.to be_file }
      it { is_expected.to contain 'APT::Periodic::Update-Package-Lists "always";' }
      it { is_expected.to contain 'APT::Periodic::Unattended-Upgrade "12h";' }
      it { is_expected.to contain 'APT::Periodic::AutocleanInterval "always";' }
    end

    describe command('apt-config dump') do
      its(:exit_status) { is_expected.to eq 0 }
      its(:stdout) { is_expected.to match %r{^APT::Periodic::Update-Package-Lists "always";$} }
      its(:stdout) { is_expected.to match %r{^APT::Periodic::Unattended-Upgrade "12h";$} }
      its(:stdout) { is_expected.to match %r{^Unattended-Upgrade::Remove-Unused-Kernel-Packages "true";$} }
      its(:stdout) { is_expected.to match %r{^Unattended-Upgrade::Remove-New-Unused-Dependencies "false";$} }
      its(:stdout) { is_expected.to match %r{^Unattended-Upgrade::OnlyOnACPower "false";$} }
    end

    describe command('unattended-upgrade --dry-run --debug') do
      its(:exit_status) { is_expected.to eq 0 }

      it 'expands only the configured origins' do
        origins = subject.stdout[%r{^Allowed origins are: (.*)$}, 1]
        expect(origins).to eq "origin=#{distro_id},suite=#{codename}-security, origin=Example,codename=stable"
      end

      its(:stdout) { is_expected.to match %r{^Initial blacklist: \.\*$} }
    end
  end
end
