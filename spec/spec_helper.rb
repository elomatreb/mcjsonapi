require "mcjsonapi"
require "digest/sha2"
require "webmock/rspec"

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.before :each do
    stub_request(:any, "http://localhost:20059/api/2/call?json=%7B%22name%22:%22server.version%22,%22username%22:%22username%22,%22key%22:%228433478ce05d331c743ff69cad00792039396d222d304545bd40f2ccecd714c9%22%7D").
      to_return(status: 200, body: '[{"result":"success","is_success":true,"source":"server.version","success":"git-Bukkit-1.6.4-R2.0-b2918jnks (MC: 1.6.4)"}]', headers: {})

    stub_request(:any, 'http://localhost:20059/api/2/call?json=%7B%22name%22:%22server.ersion%22,%22username%22:%22username%22,%22key%22:%2280e215e432f1712033c05f19d1aa25809f076f33e109459d74c3638f2054f9dd%22%7D').
      to_return(status: 200, body: '[{"result":"error","is_success":false,"error":{"message":"The method \'server.ersion\' does not exist!","code":7},"source":"server.ersion"}]', headers: {})
  end
end
