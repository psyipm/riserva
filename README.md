# Riserva

[![Build Status](https://semaphoreci.com/api/v1/igormalinovskiy/riserva/branches/master/shields_badge.svg)](https://semaphoreci.com/igormalinovskiy/riserva)
[![Code Climate](https://codeclimate.com/github/psyipm/riserva/badges/gpa.svg)](https://codeclimate.com/github/psyipm/riserva)
[![Gem Version](https://badge.fury.io/rb/riserva.svg)](https://badge.fury.io/rb/riserva)


This gem performs backup of selected folders to cloud drive. The following storages supported in current version:

* Dropbox [dropbox_api gem](https://github.com/Jesus/dropbox_api)
* Google Drive (service account) [google-drive-ruby gem](https://github.com/gimite/google-drive-ruby)

Please, refer to the documentation of corresponding gems to learn how to create storage API keys.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'riserva'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install riserva

## Usage

Riserva provides executable which is added to system PATH.

```bash
$ riserva --help
Usage: riserva [-pCv]

Specific options:
    -p, --perform=OPERATION          Operation to perform, valid options: backup (default)
    -C, --config=CONFIG              Path to riserva.yml, can also be defined as RISERVA_CONFIG environment variable

Common options:
        --help                       Show this message
    -v, --version                    Show version
```

Usage example:

```bash
riserva --config '/home/user/.riserva/config.yml' --perform backup
```

Example config:

```yaml
# Where to save created archives in local file system
storage_location: '/home/user/backup'

# Enable system notifications (if notification library installed in your OS)
system_notifications: true

# Set custom notification icon
notification_icon: '/home/user/.riserva/icon.png'

# Each folder will be compressed in separate archive
folders:
  - '/home/user/some_important_folder_1'
  - '/home/user/some_important_folder_2'
  - '/home/user/some_important_folder_3'

# Storage configuration. Multiple storage providers supported simultaneously.
storage:
  google_drive:
    secrets: '/home/user/.riserva/google_drive_secrets.json'

  dropbox:
    secrets: '/home/user/.riserva/dropbox_secrets.json'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/psyipm/riserva.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
