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

  context 'with defaults' do
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
      })
    }

    it {
      should create_file(file_periodic).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      })
    }

    it { should contain_apt__conf('auto-upgrades').with({
      'ensure' => 'absent',
    })
    }
  end

  context 'set all the things' do
    let :params do
      {
        :age                  => { 'min' => 1 },
        :size                 => { 'max' => 1000 },
        :update               => 5,
        :upgradeable_packages => {
          'download_only' => 5,
          'debdelta'      => 5,
        },
        :upgrade       => 5,
        :auto          => {
          'clean'                => '5',
          'fix_interrupted_dpkg' => false,
          'remove'               => false,
          'reboot'               => false,
        },
        :verbose             => 1,
        :legacy_origin       => true,
        :origins             => [ 'bananas' ],
        :blacklist           => [ 'foo', 'bar' ],
        :minimal_steps       => false,
        :install_on_shutdown => true,
        :mail_to             => 'root@localhost',
        :mail_only_on_error  => true,
        :dl_limit            => 70,
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
      })
    }

    it {
      should create_file(file_periodic).with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
      })
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
        }.to raise_error(Puppet::Error, /not a Hash/)
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
