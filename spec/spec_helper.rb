require "mcjsonapi"
require "digest/sha2"
require "webmock/rspec"

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.before :each do
    stub_request(:any, /localhost:20059\/api\/2\/call/).
      with(query: {"json" => '{"name":"server.version","username":"username","key":"8433478ce05d331c743ff69cad00792039396d222d304545bd40f2ccecd714c9"}'}).
      to_return(status: 200, body: '[{"result":"success","is_success":true,"source":"server.version","success":"git-Bukkit-1.6.4-R2.0-b2918jnks (MC: 1.6.4)"}]', headers: {})
  end
end
