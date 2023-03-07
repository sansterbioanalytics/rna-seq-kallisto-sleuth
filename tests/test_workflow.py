import subprocess
import pytest
from pathlib import Path

@pytest.fixture(scope="session")
def snakemake_workflow(tmp_path_factory) -> subprocess.CompletedProcess:
    """Test that the Snakemake workflow runs without errors."""
    # Setup testing directory
    test_dir = tmp_path_factory.mktemp("test_workflow")
    # Copy the workflow to the testing directory
    subprocess.run([f'cp -r workflow {test_dir}'])
    subprocess.run([f'cp -r tests {test_dir}'])
    # Construct the Snakemake command
    snakemake_cmd = f'snakemake --cores all --use-conda --directory {test_dir}/results --snakefile {test_dir}/workflow/Snakefile --configfile {test_dir}/tests/config/config.yaml'
    # Specify any additional arguments to the Snakemake command here, for example:
    snakemake_cmd += ''

    # Run the commands using subprocess.run
    print(f'Running command: {snakemake_cmd}')
    process = subprocess.run(f'{snakemake_cmd}', stdout=subprocess.PIPE,
                             stderr=subprocess.PIPE, shell=True, cwd=test_dir)
    print('Finished running Snakemake workflow')
    yield process


def test_workflow_execution(snakemake_workflow):
    """Test that the Snakemake workflow runs without errors."""
    print('Starting Snakemake workflow test')
    assert snakemake_workflow.returncode == 0
