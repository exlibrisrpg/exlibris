[![View performance data on
Skylight](https://badges.skylight.io/typical/8iNkI05QE0Bv.svg)](https://oss.skylight.io/app/applications/8iNkI05QE0Bv)
[![View performance data on
Skylight](https://badges.skylight.io/problem/8iNkI05QE0Bv.svg)](https://oss.skylight.io/app/applications/8iNkI05QE0Bv)

# Ex Libris

A database of Mörk Borg content. For [Liber Ludorum].

[Liber Ludorum]: https://liberludorum.com/2020/09/28/ex-libris-mork-borg/

## Dependencies

- Ruby 2.7.2
- Yarn
- Postgres 13
- Redis

For advice on setting up these dependencies, please see the
[wiki](https://github.com/exlibrisrpg/exlibris/wiki#setting-up-dependencies).

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

## Running locally

Start up the server with `bin/rails server`.

### Subdomains on localhost

Ex Libris RPG supports multiple systems on different subdomains. The simplest
way to manage this locally is with [puma-dev](https://github.com/puma/puma-dev).
This will run the application for you, and you can access it on
`exlibrisrpg.test` or any subdomain like `mork-borg.exlibrisrpg.test`.

```
puma-dev link -n exlibrisrpg
```

## Testing

Unit tests, system tests, security checks and linting are all packaged into
`bin/ci`. This is the set of tests and checks which are run by the CI pipeline
on GitHub.

## Theming and components

A fairly simple theming system is being introduced to allow presenting different
systems with different designs and layouts. This will mostly be based on [CSS
custom properties] and [Rails variants].

To make the process easier, components are being extracted with [ViewComponent]
so that they can be inspected in isolation with [Lookbook]. You can access
Lookbook when running the application in development at `/lookbook`. When
theming for each system is implemented, you will be able to use the appropriate
subdomain to view the component library for that particular system:

```
mork-borg.exlibrisrpg.test/lookbook
mausritter.exlibrisrpg.test/lookbook
```

[CSS custom properties]: https://developer.mozilla.org/en-US/docs/Web/CSS/Using_CSS_custom_properties
[Rails variants]: https://guides.rubyonrails.org/layouts_and_rendering.html#the-variants-option
[ViewComponent]: https://viewcomponent.org
[Lookbook]: https://github.com/allmarkedup/lookbook
