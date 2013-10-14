# Contestrus

Contestrus is a platform for hosting algorithmic competitions. It is planned to
feature:

* Different task styles. ACM ICPC (Accepted/Not accepted), IOI (Partial scores),
  Open/Hidden Input.
* Customized contest forms. Contestrus comes with built-in importers for a
  simple contest format, but it's easy to write importers from an existing
  format.
* Simple, fast interface. A useful interface that helps the participants as much
  as possible.
* API. An API that lets users submit their programs via an API and view their
  status.
* Sandboxing. Sandboxing is provided by running each submission within its own
  Docker container.
* Administration interface. An interface to monitor and edit contests.
* Contest and training. Support both running contests but also an open
  environment to train on tasks of previous contests.

Many contest environments are complicated to set up. Contestrus is aimed to be
extremely simple to run within Docker containers.

## External dependencies

Contestrus has PostgreSQL as its only external dependency.

**Note:** Currently Contestrus uses sqlite3 but will eventually switch to
PostgresSQL, because sqlite3 will not play nicely with the Docker architecture
planned for Contestrus.

## Development

Run `script/bootstrap`. This sets up your development environment:

* Vendor all Contestrus' dependencies.
* Creates the database.
* Seeds the database with initial settings.

Run `bin/rake` to test Contestrus on your own machine.

## Importing contests

The default importer uses the format in `/contests`. You can import all your
contests in this folder with: `rake tasks:add`.
