import subprocess
import pytest


@pytest.fixture()
def snakemake_workflow(tmp_path) -> int:
    """Test that the Snakemake workflow runs without errors."""
    print('Starting Snakemake workflow test')
    # Construct the Snakemake command
    snakemake_cmd = 'snakemake --use-conda --directory tests'
    # Specify any additional arguments to the Snakemake command here, for example:
    snakemake_cmd += ' --cores 4'
    # Copy the test data to a temporary directory
    command = f'cp -r tests/data {tmp_path}'
    # Change the working directory to the temporary directory
    command += f' && cd {tmp_path}/data'
    
    # Run the commands using subprocess.run
    print(f'Running command: {command}')
    process = subprocess.run(f'{command}', stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    print('Finished running setup commands')
    print(f'Running command: {snakemake_cmd}')
    process = subprocess.run(f'{snakemake_cmd}', stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    print('Finished running Snakemake workflow')
    return process.returncode

def test_workflow_execution(snakemake_workflow):
    """Test that the Snakemake workflow runs without errors."""
    assert snakemake_workflow == 0