#!/usr/bin/env python
from cProfile import run
import os
import subprocess


PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)

kata_name = '{{ cookiecutter.kata_name}}'


def run_command(command):
    completed_process = subprocess.run(command, cwd=PROJECT_DIRECTORY, shell=True, check=True, timeout=360)
    if completed_process.returncode != 0:
        raise Exception(f'Command {command} failed with return code {completed_process.returncode}')


if __name__ == '__main__':
    print('😻 Running the setup scripts ...')
    run_command('chmod +x scripts/*.sh')
    run_command('./scripts/start.sh ' + kata_name)
    print('😻 remove the helper scripts...')
    run_command('rm -r scripts')
    print('😻 finalize the script removal...')
    run_command(f'git commit -a -m "chore: script directory removal"')
    run_command(f'git push -u origin main')