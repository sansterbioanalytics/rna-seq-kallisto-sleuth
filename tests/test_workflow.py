import subprocess
import pytest
from pathlib import Path

@pytest.fixture(scope="session")
def snakemake_workflow(tmp_path_factory: Path) -> subprocess.CompletedProcess:
    """Test that the Snakemake workflow runs without errors."""
    # Setup testing directory
    test_dir = tmp_path_factory.mktemp("workflow_test") / "kallisto-sleuth"
    # Copy the workflow to the testing directory
    subprocess.run([f'pwd'])
    subprocess.run([f'cp -r workflow {test_dir}/workflow'])
    subprocess.run([f'cp -r tests {test_dir}/tests'])
    # Construct the Snakemake command
    snakemake_cmd = f'snakemake --cores all --use-conda --directory tests --snakefile workflow/Snakefile --configfile tests/config/config.yaml'
    # Specify any additional arguments to the Snakemake command to test individual modules, for example:
    snakemake_cmd += ''

    # Run the commands using subprocess.run
    print(f'Running command: {snakemake_cmd}')
    completed_process = subprocess.run([snakemake_cmd], cwd=test_dir, shell=True, check=True)
    print('Finished running Snakemake workflow')
    return completed_process


def test_workflow_execution(snakemake_workflow):
    """Test that the Snakemake workflow runs without errors."""
    print('Starting Snakemake workflow test')
    assert snakemake_workflow.returncode == 0
