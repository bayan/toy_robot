# ToyRobot Coding Challenge

Technical interview coding take home test. See [ROBOT_CHALLENGE_DESCRIPTION.md](ROBOT_CHALLENGE_DESCRIPTION.md) for details on the requirements for the challenge.

## Usage

This repository uses Ruby, and has been tested successfully using [version 3.2.2](.ruby-version) and [Bundler](https://bundler.io/). It can be built and installed locally as a Ruby Gem, or run entirely using Bundler.

### Install and run locally as a Ruby Gem

```console
$ git clone https://github.com/bayan/toy_robot.git
$ cd toy_robot
$ bundle install
$ gem build toy_robot.gemspec
$ gem install ./toy_robot-0.1.0.gem
```

Running the above commands successfully will install an executable called `robot_sim` in your Gem installation directory. For example, if you are using the Homebrew installed version of Ruby 3.2.2, on your system, Ruby Gem executables may be located here: `/opt/homebrew/lib/ruby/gems/3.2.0/bin/`. You can get some help by running the following command:

```console
$ /path/to/robot_sim --help
Commands:
                            # Run the Toy Robot Simulation
  robot_sim help [COMMAND]  # Describe available commands or one specific command
  robot_sim version         # Display the version.
```

Run the toy robot simulator with this command:

```console
$ /path/to/robot_sim --size 5
```

Start entering commands (as described in the [challenge specification](ROBOT_CHALLENGE_DESCRIPTION.md)). Ctrl-C or Ctrl-D to exit the simulator.

Alternatvily, you can pipe in some commands directly from a file:
```console
$ cat test/examples/example1.txt | /path/to/robot_sim --size 5
Output: 0,1,NORTH
```

### Run locally using Bundler in development mode.

Refer to Development instructions below.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bayan/toy_robot. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/bayan/toy_robot/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ToyRobot project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/bayan/toy_robot/blob/main/CODE_OF_CONDUCT.md).
