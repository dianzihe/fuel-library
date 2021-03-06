require File.join File.dirname(__FILE__), '../test_common.rb'

class MuranoPostTest < Test::Unit::TestCase

  def test_murano_is_running
    assert TestCommon::Process.running?('murano-api'), 'Murano-api is not running!'
  end

  def test_murano_engine_pacemaker_service_running
    assert TestCommon::Pacemaker.primitive_started?('p_openstack-murano-engine'), 'Murano-engine Pacemaker service is not started!'
  end

  def test_murano_haproxy_backend_online
    assert TestCommon::HAProxy.backend_up?('murano'), 'Murano HAProxy backend is not up!'
  end

  def test_murano_rabbitmq_haproxy_backend_online
    assert TestCommon::HAProxy.backend_up?('murano_rabbitmq'), 'Murano_rabbitmq HAProxy backend is not up!'
  end

  def test_murano_api_url_accessible
    ip = TestCommon::Settings.management_vip
    port = 8082
    url = "http://#{ip}:#{port}"
    assert TestCommon::Network.url_accessible?(url), "Murano-api url '#{url}' is not accessible!"
  end

end
