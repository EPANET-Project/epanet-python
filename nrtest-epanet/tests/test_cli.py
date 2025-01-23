


import os
import subprocess

import pytest



DATA_PATH = os.path.join(os.path.abspath(os.path.dirname(__file__)), 'data')
EXPECTED_OUTPUT = os.path.join(DATA_PATH, 'expected-output.txt')



@pytest.mark.parametrize("flag", ["-h", "--help"])
def test_report_diff_help_flags(flag):
    """
    Test that the 'report-diff' entry point responds correctly to -h and --help.
    """
    # Read expected output from file
    with open(EXPECTED_OUTPUT, 'r') as file:
        expected = file.read().strip()


    result = subprocess.run(
        ["report-diff", flag],
        capture_output=True,
        text=True,
    )

    # Assert the command runs successfully (exit code 0)
    assert result.returncode == 0, f"Command failed with stderr: {result.stderr}"

    # Assert the output contains expected help text
    assert expected == result.stdout.strip()
