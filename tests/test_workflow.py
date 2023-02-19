import subprocess
import pytest


@pytest.fixture()
def snakemake_workflow(tmp_path) -> int:
    """Test that the Snakemake workflow runs without errors."""
    print('Starting Snakemake workflow test')
    # Construct the Snakemake command
    snakemake_cmd = 'snakemake --cores 4 --use-conda --directory tests --snakefile workflow/Snakefile --configfile tests/config/config.yaml'
    # Specify any additional arguments to the Snakemake command here, for example:
    snakemake_cmd += ''
   
    # Run the commands using subprocess.run
    print(f'Running command: {snakemake_cmd}')
    process = subprocess.run(f'{snakemake_cmd}', stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    print('Finished running Snakemake workflow')
    return process.returncode

def test_workflow_execution(snakemake_workflow):
    """Test that the Snakemake workflow runs without errors."""
    assert snakemake_workflow == 0