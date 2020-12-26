# LocalStack AWS CLI

[![PyPI version][pypi-version]][pypi]

This package provides the `awslocal` command, which is a thin wrapper around the `aws`
command line interface for use with [LocalStack](https://github.com/localstack/localstack).

## Installation

You can install the `awslocal` command via `pip`:

```
pip install awscli-local[ver1]
```

Note that the command above also installs the latest version of the underlying AWS CLI version 1 (`awscli`) package. Use this command if you prefer to manage your own version of `awscli` (e.g., `v1`/`v2`) and install the wrapper script only:
```
pip install awscli-local
```

**Note:** Automatic installation of AWS CLI version 2 is currently not supported yet (at the time of writing there is no official pypi package for `v2` available), but the `awslocal` command should technically also work with AWS CLI v2.

## Usage

The `awslocal` command has the same usage as the `aws` command. For detailed usage,
please refer to the man pages of `aws help`.

## Example

Instead of the following command ...

```
aws --endpoint-url=http://localhost:4566 kinesis list-streams
```

... you can simply use this:

```
awslocal kinesis list-streams
```

## Configurations

You can use the following environment variables for configuration:

* `LOCALSTACK_HOST`: Set the hostname for the localstack instance. Useful when you have
localstack is bound to another interface (i.e. docker-machine).
* `USE_SSL`: Whether to use `https` endpoint URLs (required if LocalStack has been started
with `USE_SSL=true` enabled). Defaults to `false`.
* `DEFAULT_REGION`: Set the default region. Overrides `AWS_DEFAULT_REGION` environment variable.

## Change Log

* v0.13: Fix extra requires for newer pip versions
* v0.12: Support v1 and v2 of underlying `awscli` installation
* v0.9: Add `--s3-endpoint-url` by default to fix "cloudformation package" command
* v0.9: Support for `DEFAULT_REGION` environment variable
* v0.8: Switch to using edge port for all service endpoints by default
* v0.7: Apply runtime patch to aws-cli to enable `--s3-endpoint-url` CloudFormation parameter
* v0.6: Start `aws` CLI command in-memory instead of calling external process
* v0.5: Support piping binary files to stdout; add .bat file for Windows
* v0.4: Minor fix for Python 3 compatibility
* v0.3: Add support for additional service endpoints
* v0.2: Enable SSL connections; refactor code
* v0.1: Initial release

## License

This software library is released under the Apache License, Version 2.0 (see `LICENSE`).

[pypi-version]: https://img.shields.io/pypi/v/awscli-local.svg
[pypi]: https://pypi.org/project/awscli-local/
