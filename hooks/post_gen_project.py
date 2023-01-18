#!/usr/bin/env python
from cProfile import run
import os
import subprocess


PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)

kata_name = '{{ cookiecutter.kata_name}}'


def run_command(command):
    subprocess.run(command, cwd=PROJECT_DIRECTORY, shell=True, check=True, timeout=360)


if __name__ == '__main__':
    run_command('git init')
    run_command('npm install')
    run_command('npm test')
    run_command('ls -la')
    run_command('scripts/start.sh ' + kata_name)