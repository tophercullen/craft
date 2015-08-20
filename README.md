craft Cookbook
==============
Installs and configures Craft CMS


Requirements
------------
The following cookbooks are required
  * 'apache2'
  * 'maven'
  * 'ark'

Attributes
----------
#### Install
Default version is a combination of major and minor versions. 
  * `default['craft']['install']['version']['major']`
  * `default['craft']['install']['version']['minor']`
Craft home directly for all things craft
  * `default['craft']['craft_home']`
Set to true if you want to write out a craft license
  * `default['craft']['license']`
### DB
  * `default['craft']['db']['host']`
  * `default['craft']['db']['user']`
  * `default['craft']['db']['password']`
  * `default['craft']['db']['database']`
  * `default['craft']['db']['prefix']`
##Apache
Defines listening ports and a cert. A self-signed cert will be created if it doesn't exist
  * `default['craft']['ports']['http_port']`
  * `default['craft']['ports']['https_port']`
  * `default['craft']['cert']`

Usage
-----
Just include `craft` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[craft]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Topher Cullen (topher.cullen@jamberry.com)

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
