# LocalStack AWS CLI

[![PyPI version][pypi-version]][pypi]

This package provides the `awslocal` command, which is a thin wrapper around the `aws`
command line interface for use with [LocalStack](https://github.com/localstack/localstack).

## Installation

You can install the `awslocal` command via `pip`:

```
pip install awscli-local
```

## Usage

The `awslocal` command has the same usage as the `aws` command. For detailed usage,
please refer to the man pages of `aws help`.

## Example

Instead of the following command ...

```
aws --endpoint-url=http://localhost:4568 kinesis list-streams
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
* `DEFAULT_REGION`: Set the default region. Overrides `AWS_DEFAULT_REGION` environment varible.

## Change Log

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
