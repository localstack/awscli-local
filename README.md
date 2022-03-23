# LocalStack AWS CLI

[![PyPI version][pypi-version]][pypi]

This package provides the `awslocal` command, which is a thin wrapper around the `aws`
command line interface for use with [LocalStack](https://github.com/localstack/localstack).

## Installation

You can install the `awslocal` command via `pip`:

```console
pip install awscli-local[ver1]
```

Note that the command above also installs the latest version of the underlying AWS CLI version 1 (`awscli`) package. Use this command if you prefer to manage your own version of `awscli` (e.g., `v1`/`v2`) and install the wrapper script only:
```console
pip install awscli-local
```

**Note:** Automatic installation of AWS CLI version 2 is currently not supported yet (at the time of writing there is no official pypi package for `v2` available), but the `awslocal` technically also works with AWS CLI v2 (see [this section](#Limitations) for more details).

## Usage

The `awslocal` command has the same usage as the `aws` command. For detailed usage,
please refer to the man pages of `aws help`.

## Example

Instead of the following command ...

```console
aws --endpoint-url=http://localhost:4566 kinesis list-streams
```

... you can simply use this:

```console
awslocal kinesis list-streams
```

## Configurations

You can use the following environment variables for configuration:

* `LOCALSTACK_HOST`: Set the hostname for the localstack instance. Useful when you have
localstack is bound to another interface (i.e. docker-machine).
* `USE_SSL`: Whether to use `https` endpoint URLs (required if LocalStack has been started
with `USE_SSL=true` enabled). Defaults to `false`.
* `DEFAULT_REGION`: Set the default region. Overrides `AWS_DEFAULT_REGION` environment variable.

## Limitations

* Please note that there is a known limitation for using the `cloudformation package ...` command with the AWS CLI v2. The problem is that the AWS CLI v2 is [not available as a package on pypi.org](https://github.com/aws/aws-cli/issues/4947), but is instead shipped as a binary package that cannot be easily patched from `awslocal`. To work around this issue, you have 2 options:

   - Downgrade to the v1 AWS CLI (this is the recommended approach)
   - There is an inofficial way to install AWS CLI v2 from sources. We do not recommend this, but it is technically possible. Also, you should install these libraries in a Python virtualenv, to avoid version clashes with other libraries on your system:
```console
virtualenv .venv
. .venv/bin/activate
pip install https://github.com/boto/botocore/archive/v2.zip https://github.com/aws/aws-cli/archive/v2.zip
```

## Change Log

* v0.19: Patch botocore to skip adding `data-` host prefixes to endpoint URLs
* v0.18: Pass `SYSTEMROOT` env variable to fix "_Py_HashRandomization_Init" error on Windows
* v0.17: Remove obsolete/erroneous FORCE_V2 flag
* v0.16: Minor fix reading addressing_style in profile config
* v0.15: Fix lookup of v1/v2 AWS CLI version, apply --s3-endpoint-url only for v1
* v0.14: Quote file name for windows to allow folder names with spaces
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

## Alternative

This package can be replaced by a single bash alias, except for `cloudformation package ...` as this command requires an additional `--s3-endpoint-url` parameter:
```console
alias awslocal="AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test AWS_DEFAULT_REGION=${DEFAULT_REGION:-$AWS_DEFAULT_REGION} aws --endpoint-url=http://${LOCALSTACK_HOST:-localhost}:4566"
```

## License

This software library is released under the Apache License, Version 2.0 (see `LICENSE`).

[pypi-version]: https://img.shields.io/pypi/v/awscli-local.svg
[pypi]: https://pypi.org/project/awscli-local/
