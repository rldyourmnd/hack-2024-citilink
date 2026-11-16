set shell := ["bash", "-euo", "pipefail", "-c"]

# Lists the maintained demo commands.
default:
    @just --list

# Installs declared dependencies as wheels with the prepared Python interpreter.
setup:
    uv venv --python python .venv
    uv pip install --no-build --python .venv/bin/python -r requirements.txt

# Parses maintained source without importing it or writing bytecode.
check:
    just --fmt --check
    python -m ast app.py > /dev/null
    python -m ast clever_search.py > /dev/null
    python -m ast neuro_mentor.py > /dev/null
    python -m ast tests/test_clients.py > /dev/null

# Formats the project command file.
fix:
    just --fmt

# Runs the retained offline client regressions without provider requests.
test:
    .venv/bin/python -m unittest discover -s tests -v

# Runs every maintained demo check.
verify: check test
