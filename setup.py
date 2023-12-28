#!/usr/bin/env python

from setuptools import setup

description = 'Thin wrapper around the "aws" command line interface for use with LocalStack'
README = description

try:
    with open('README.md') as f:
        README = f.read()
except Exception:
    pass


if __name__ == '__main__':

    setup(
        name='awscli-local',
        version='0.22.0',
        description=description,
        long_description=README,
        long_description_content_type='text/markdown',
        author='LocalStack Team',
        author_email='info@localstack.cloud',
        url='https://github.com/localstack/awscli-local',
        packages=[],
        scripts=['bin/awslocal', 'bin/awslocal.bat'],
        package_data={},
        data_files={},
        install_requires=['localstack-client'],
        extras_require={
            'ver1': ['awscli'],
        },
        license="Apache License 2.0",
        classifiers=[
            "Programming Language :: Python :: 2",
            "Programming Language :: Python :: 2.6",
            "Programming Language :: Python :: 2.7",
            "Programming Language :: Python :: 3",
            "Programming Language :: Python :: 3.3",
            "Programming Language :: Python :: 3.6",
            "Programming Language :: Python :: 3.7",
            "Programming Language :: Python :: 3.8",
            "Programming Language :: Python :: 3.9",
            "License :: OSI Approved :: Apache Software License",
            "Topic :: Software Development :: Testing"
        ]
    )
