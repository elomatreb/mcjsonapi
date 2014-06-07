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

    stub_request(:any, 'http://localhost:20059/api/2/call?json=%7B%22name%22:%22players.online%22,%22username%22:%22username%22,%22key%22:%22a512138b40aa90e62577a05b22e0a8ef1e3642603766c5f175a91b491143ec0a%22%7D').
      to_return(status: 500, body: "")

    stub_request(:any, 'http://localhost:20059/api/2/call?json=%7B%22name%22:%22players.online.limit%22,%22username%22:%22username%22,%22key%22:%229e13123716483673352415a76bc891649148043111cbffa3374ee192d26e8e34%22%7D').
      to_timeout

    stub_request(:any, 'http://localhost:20059/api/2/call?json=%7B%22name%22:%22chat.broadcast%22,%22arguments%22:%5B%5D,%22username%22:%22username%22,%22key%22:%2209cb37400a6951f6f69ac62c736c62e8646292a100585bf4412a836b4c507407%22%7D').
      to_return(status: 200, body: '[{"result":"error","is_success":false,"error":{"message":"Caught exception: java.lang.Exception: Incorrect number of args: gave 0 ([]), expected 1 for method chat.broadcast\n\tat com.alecgorge.minecraft.jsonapi.dynamic.Caller.call(Caller.java:64)\n\tat com.alecgorge.minecraft.jsonapi.api.v2.JSONResponse.serveAPICall(JSONResponse.java:130)\n\tat com.alecgorge.minecraft.jsonapi.api.v2.JSONResponse.getJSONObject(JSONResponse.java:73)\n\tat com.alecgorge.minecraft.jsonapi.api.v2.APIv2Handler.call(APIv2Handler.java:83)\n\tat com.alecgorge.minecraft.jsonapi.api.v2.APIv2Handler.serve(APIv2Handler.java:51)\n\tat com.alecgorge.minecraft.jsonapi.JSONServer.serve(JSONServer.java:257)\n\tat com.alecgorge.minecraft.jsonapi.NanoHTTPD$HTTPSession.run(NanoHTTPD.java:553)\n\tat java.lang.Thread.run(Thread.java:744)\n","code":6},"source":"chat.broadcast"}]') # This is ugly. Like, really ugly.

    stub_request(:any, 'http://localhost:20059/api/2/call?json=%7B%22name%22:%22chat.broadcast%22,%22arguments%22:%5B%22Hello%20World%22%5D,%22username%22:%22username%22,%22key%22:%2209cb37400a6951f6f69ac62c736c62e8646292a100585bf4412a836b4c507407%22%7D').
      to_return(status: 200, body: '[{"result":"success","is_success":true,"source":"chat.broadcast","success":1}]')
  end
end
