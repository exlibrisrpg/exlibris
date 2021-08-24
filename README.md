[![View performance data on
Skylight](https://badges.skylight.io/typical/8iNkI05QE0Bv.svg)](https://oss.skylight.io/app/applications/8iNkI05QE0Bv)
[![View performance data on
Skylight](https://badges.skylight.io/problem/8iNkI05QE0Bv.svg)](https://oss.skylight.io/app/applications/8iNkI05QE0Bv)

# Ex Libris

A database of Mörk Borg content. For [Liber Ludorum].

##Pre-requisites

1. Have libpq-dev installed. 
`sudo apt install libpq-dev`

2. Postgresql

2a. Install postgresql
`sudo apt install postgresql-12`

2b. Create user
There must be a role in postgresql with the same name being used to run `bin/setup` later.

2c. Privileges
The user must also have createdb privileges.
`alter user <username> createdb`

## Setup

To get this running locally run `bin/setup`. You can also use the `-f` flag to
generate the test fixtures in the development database (helpful for local test
content).

```
$ bin/setup -h
Setup Ex Libris' dependencies and database

Usage: bin/ci [options]
    -f, --with-fixtures              Load fixtures into database
    -h, --help                       Prints this help message
```

## Testing

Unit tests, system tests, security checks and linting are all packaged into
`bin/ci`. This is the set of tests and checks which are run by the CI pipeline
on GitHub.

[Liber Ludorum]: https://liberludorum.com/2020/09/28/ex-libris-mork-borg/
