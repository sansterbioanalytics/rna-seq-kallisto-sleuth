import subprocess

# Change directory to the location of the Snakefile
workflow_dir = '../workflow/'
command = f'cd {workflow_dir};'

# Construct the Snakemake command
snakemake_cmd = 'snakemake'

# Specify any additional arguments to the Snakemake command here, for example:
# snakemake_cmd += ' --cores 4'

# Run the Snakemake command using subprocess
process = subprocess.Popen(f'{command} {snakemake_cmd}', shell=True)
process.wait()
