require 'spec_helper'

describe 'graphite', :type => :class do
  let(:facts) { {
    :osfamily => 'debian',
    :operatingsystemrelease => '12.04',
    :concat_basedir => '/var/lib/puppet/concat'
  } }
  it { should create_class('graphite::config')}
  it { should create_class('graphite::install')}
  it { should create_class('graphite::service')}

  it { should contain_package('whisper')}
  it { should contain_package('graphite-web')}
  it { should contain_package('carbon')}

  it { should contain_service('carbon') }
  it { should contain_service('httpd') }

  it { should contain_apache__vhost('graphite').with_port(80) }

  context 'with host' do
    let(:params) { {'port' => 9000} }
    it { should contain_apache__vhost('graphite').with_port(9000) }
  end

  context 'with admin password' do
    let(:params) { {'admin_password' => 'should be a hash' }}
    it { should contain_file('/opt/graphite/webapp/graphite/initial_data.json').with_content(/should be a hash/) }
  end

end
