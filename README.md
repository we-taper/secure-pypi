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
uv init test_project --vcs none --python ">=3.9"
cd test_project && uv add python-dotenv roto
uv export --format requirements-txt > requirements.txt
```

Install and use Snyk to scan the dependencies in the lock file.

```bash
todo
```