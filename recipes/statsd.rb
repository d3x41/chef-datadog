# Copyright:: 2011-Present, Datadog
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe '::dd-agent'

# Monitor StatsD
#
# Here is the description of acceptable attributes:
# node.datadog.statsd = {
#   # init_config - required: false
#   "init_config" => {
#     # service - required: false  - string
#     "service" => nil,
#   },
#   # instances - required: false
#   "instances" => [
#     {
#       # host - required: true  - string
#       "host" => "localhost",
#       # port - required: true  - integer
#       "port" => 8126,
#       # timeout - required: false  - integer
#       "timeout" => 10,
#       # tags - required: false  - array of string
#       "tags" => [
#         "<KEY_1>:<VALUE_1>",
#         "<KEY_2>:<VALUE_2>",
#       ],
#       # service - required: false  - string
#       "service" => nil,
#       # min_collection_interval - required: false  - number
#       "min_collection_interval" => 15,
#       # empty_default_hostname - required: false  - boolean
#       "empty_default_hostname" => false,
#     },
#   ],
# }

datadog_monitor 'statsd' do
  init_config node['datadog']['statsd']['init_config']
  instances node['datadog']['statsd']['instances']
  logs node['datadog']['statsd']['logs']
  use_integration_template true
  action :add
  notifies :restart, 'service[datadog-agent]' if node['datadog']['agent_start']
end
