"""Tests for prepare_cmd_args in bin/awslocal.

bin/awslocal has no .py extension, so it is loaded with SourceFileLoader.
localstack_client is stubbed: endpoint resolution is the only behavior
needed here, and the real package is an unrelated optional dependency.
"""

import sys
import types
from importlib.machinery import SourceFileLoader
from pathlib import Path

import pytest

BIN = Path(__file__).resolve().parent.parent / "bin" / "awslocal"


def _load_awslocal(monkeypatch):
    fake = types.ModuleType("localstack_client")

    class FakeConfig:
        @staticmethod
        def get_service_endpoints(localstack_host=None):
            return {"sts": "http://localhost:4566", "s3": "http://localhost:4566"}

    fake.config = FakeConfig()
    monkeypatch.setitem(sys.modules, "localstack_client", fake)
    return SourceFileLoader("awslocal_under_test", str(BIN)).load_module()


def test_prepare_cmd_args_inserts_endpoint_once(monkeypatch):
    awslocal = _load_awslocal(monkeypatch)
    monkeypatch.setattr(sys, "argv", ["awslocal", "s3", "ls"])
    cmd_args = awslocal.prepare_cmd_args()
    assert cmd_args.count("--endpoint-url=http://localhost:4566") == 1


def test_prepare_cmd_args_is_repeatable(monkeypatch):
    """Calling prepare_cmd_args twice must not duplicate flags.

    Regression test: cmd_args aliased sys.argv, so every call inserted
    another --endpoint-url into the live argv list.
    """
    awslocal = _load_awslocal(monkeypatch)
    monkeypatch.setattr(sys, "argv", ["awslocal", "s3", "ls"])
    first = awslocal.prepare_cmd_args()
    second = awslocal.prepare_cmd_args()
    assert first.count("--endpoint-url=http://localhost:4566") == 1
    assert second.count("--endpoint-url=http://localhost:4566") == 1
    assert sys.argv.count("--endpoint-url=http://localhost:4566") <= 1


if __name__ == "__main__":
    pytest.main([__file__])
