# Semaph

This is command line shell for interacting with [semaphoreci 2.0](http://docs.semaphoreci.com/).

It complements the [sem](https://docs.semaphoreci.com/reference/sem-command-line-tool/) tool with some
overlap in responsibilities.


## Installation

    gem install semaph

## Usage

To set up authentication to semaphoreci, you can just follow the instructions to install and setup
[sem](https://docs.semaphoreci.com/reference/sem-command-line-tool/).  This will result
in your authentication details being written to `~/.sem.yaml`.

You should see something like the following in this file:

```yaml
active-context: foo_semaphoreci_com
contexts:
  foo_semaphoreci_com:
    auth:
      token: qwerty
    host: foo.semaphoreci.com
```

Now you can run `semaph` and will be presented with a prompt like one of the following:

     🏗  >

or

     🏗  foo.semaphoreci.com >

This is the first of a series of nested shells.  Each shell represents a different context
and has different commands available.  To see the commands available, execute `help` and
to see the details of a particular command, execute `help <command name>`.  Once you are
familar with the commands for each context, you can type the first couple of characters
and then hit tab to complete the rest.  For some commands you can also tab complete the
parameters. Once you enter a shell, return to the previous shell or exit `semaph`, you can
press ctrl-d.

### organisations shell

     🏗  >

You will only see this shell if you have multiple sets of credentials in your `~/.sem.yml` file.

From this shell, you can `list-organisations` you are authenticated to and `select-organisation`
to enter a shell for that organisation.

### organisation shell

     🏗  foo.semaphoreci.com >

If you have only one set of credentials in `~/.sem.yml` then this will be the initial shell.

From here you can `list-projects` and then `select-project` to enter a shell for that project.

If new projects have been added/removed while you are using this shell, you can `reload-projects`.

### project shell

     🏗  foo.semaphoreci.com my-app >

From this shell, you will mostly be interested in `list-workflows <branch>` (where 'branch' is any
substring of the git branch you want to see workflows for) and then `select-workflow <index>`
(where 'index' is the number displayed for each workflow `list-workflows` - tab completion on uuids
seemed a bad idea) to enter a shell for that specific workflow.

You can also `open-github` (opens a web browser for the github project associated with the project), `open-project`
(opens the semaphoreci project in a browser) and `reload-workflows` (to see any new/changed workflows).

### workflow shell

    🏗  foo.semaphoreci.com my-app workflowuuid >

From this shell, you can `list-pipelines` for the selected workflow.  These are the builds usually starting
from `semaphore.yml` plus any promotion pipelines that might be executed.  You can `select-pipeline` to monitor
what's happening with the pipeline.

You can also `open-github-branch`, `open-github-commit` to see the branch/commit in a browser and
`open-workflow`, `open-branch` to see the semaphore branch/workflow in a browser and `reload-pipelines` to see
any changes that have happened in semaphore.

#### pipeline shell

    🏗  foo.semaphoreci.com my-app workflowuuid semaphore.yml >

From this shell, you can `list-jobs` and `reload-jobs`.

Jobs are displayed with a flattened view of blocks and jobs for compactness.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/markryall/semaph. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/markryall/semaph/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Semaph project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/markryall/semaph/blob/master/CODE_OF_CONDUCT.md).
