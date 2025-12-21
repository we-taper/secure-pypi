# Goal

Distribute pure python package in a single file with all dependencies included. Scan all the code including dependencies for security or malware issues.

**Approach**

External Tools Used:
- zipapp: a Python built-in module to create a single zip file which can be executed given a compatible Python interpreter. Website: 
- GuardDog: a security tool to scan source code for vulnerabilities and malware. Supports scanning of Python code, and supports detection of malware patterns. It employs static code analysis tool, SemGrep (semantic grep) under the hood. Website:
- uv: a Python environment manager which supports dependencies pinning, generates a lock file. It can also install all dependencies in a target folder, which is required for packaging with zipapp. Website:
- Snyk: an online security tool to scan dependencies for known vulnerabilities. Supports uv lock files. Website:

Other considerations:
- Use an automated tool to check if the package is compatible with multiple Python versions.

# Step by Step Instructions

*Preparation*
Prepare a system with required tools. See details in the Dockerfile.

*uv*
Initiate a project with uv, add dependencies, with a lock file automatically generated. Note that vcs is skipped since it is managed outside the project.

```bash
uv init test_project --vcs none --package --python ">=3.9"
cd test_project && uv add requests
uv export  --no-dev --no-emit-project --format requirements-txt > requirements.txt
```

Note:
- If available, `uv` will use existing git repository information to populate the project metadata.

*zipapp*
Install dependencies in a target folder, then package the project with zipapp.
```bash
PROJECT_DIR=test_project
cd $PROJECT_DIR
uv export  --no-dev --no-emit-project --format requirements-txt > requirements.txt
uv pip install --target ./zipapp_build/ -r requirements.txt
rm -rf ../zipapp_build/ && mv zipapp_build ../
# copy contents under src/ to zipapp_build/
cp -R src/* ../zipapp_build/
cd ../zipapp_build/
uv run python -m zipapp . -o ../main.pyz -m "$PROJECT_DIR.__main__:main" -p "/usr/bin/env python3"
```

*Snyk*
Setup and use Snyk to scan the dependencies in the lock file.
- Signup for Snyk and connect it to your GitHub account.
- Upload this package as a public repository to GitHub.
- In Snyk, import the GitHub repository. Snyk will automatically detect the generated requirements.txt file and scan for vulnerabilities.

*GuardDog*
- GuardDog is better installed separated. For example, `pip install guarddog` in the host system.
- Use GuardDog to scan the source code including dependencies.
```bash
guarddog pypi scan ./zipapp_build
```