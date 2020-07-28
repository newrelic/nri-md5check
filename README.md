[![Experimental header](https://github.com/newrelic/opensource-website/raw/master/src/images/categories/Experimental.png)](https://opensource.newrelic.com/oss-category/#experimental)

# MD5 - File Modification Check
Infrastructure extension to validate if a file changed or not through MD5sum utility.

## Requirements
* Infrastructure agent installed
* MD5sum utility installed
* Privileges to access file being validated

## Installation

1. Copy repo to machine running Infrastructure
2. Configure md5-config.yml with the full path to your FILE_TO_CHECK
3. Run `install.sh` as root

## Configuration
Edit the arguments stanza in `md5-config.yml` with what file you want to monitor. The `labels` stanza is used if you would like to associate certain attributes with the file being checked.

Example:
```
integration_name: com.newrelic.md5

instances:
  - name: FileCheck1
    command: md5
    arguments:
      FILE_TO_CHECK: "/etc/sudoers"
    labels:
      filename: sudoers
      env: dev
```

The default interval that the extension runs is 90 seconds. This can be modified within `md5-definition.yml`.

## Event Data
Events will be displayed under **MD5Sample** within NRDB. The extension reports a `true` or `false` message if your specified file changes. You will also see the `md5checksum` value (before and after it changed).

## Notes
* Does not currently support validation of multiple files


## Contributing
We encourage your contributions to improve nri-md5check! Keep in mind when you submit your pull request, you'll need to sign the CLA via the click-through using CLA-Assistant. You only have to sign the CLA one time per project.
If you have any questions, or to execute our corporate CLA, required if your contribution is on behalf of a company,  please drop us an email at opensource@newrelic.com.

## License
nri-md5check is licensed under the [Apache 2.0](http://apache.org/licenses/LICENSE-2.0.txt) License.
