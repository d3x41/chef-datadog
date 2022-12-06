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

# Encoding: utf-8

require 'spec_helper'

AGENT_CONFIG = File.join(@agent_config_dir, 'conf.d/twemproxy.d/conf.yaml')

describe service(@agent_service_name) do
  it { should be_running }
end

describe file(AGENT_CONFIG) do
  it { should be_a_file }

  it 'is valid yaml matching input values' do
    generated = YAML.load_file(AGENT_CONFIG)

    expected = {
      instances: [
        {
          url: 'http://localhost:22222'
        }
      ],
      'logs' => nil,
      init_config: {}
    }

    expect(generated.to_json).to be_json_eql expected.to_json
  end

  describe package('dd-check-twemproxy') do
    it { should be_installed.with_version('0.1.0-1') }
  end
end
