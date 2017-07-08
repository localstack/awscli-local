#!/usr/bin/env python

from setuptools import setup

if __name__ == '__main__':

    setup(
        name='awscli-local',
        version='0.2',
        description='Thin wrapper around the "aws" command line interface for use with LocalStack',
        author='Waldemar Hummer',
        author_email='waldemar.hummer@gmail.com',
        url='https://github.com/localstack/awscli-local',
        packages=[],
        scripts=['bin/awslocal'],
        package_data={},
        data_files={},
        install_requires=['awscli', 'localstack-client'],
        license="Apache License 2.0",
        classifiers=[
            "Programming Language :: Python :: 2",
            "Programming Language :: Python :: 2.6",
            "Programming Language :: Python :: 2.7",
            "Programming Language :: Python :: 3",
            "Programming Language :: Python :: 3.3",
            "License :: OSI Approved :: Apache Software License",
            "Topic :: Software Development :: Testing",
        ]
    )
