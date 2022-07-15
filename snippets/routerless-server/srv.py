from http import server
import logging
import os

PORT = int(os.getenv("LOL_PORT"))
HOST = os.getenv("LOL_HOST")

if not PORT or not HOST:
    print('export LOL_PORT=8000')
    print('export LOL_HOST=127.0.0.1')
    exit(1)

logger = logging.getLogger()
logger.addHandler(logging.StreamHandler())
logger.setLevel(logging.DEBUG)

def print(*args):
    logging.critical(*args)

class LolHandler(server.BaseHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        logger.debug(f"{args=}")
        logger.debug(f"{kwargs=}")
        print(self.path)
        print(self.address_string())
        print(self.command)
        print(self.headers)
        print(self.request)
        #print(self.responses)

    def log_message(self, *args):
        print(*args)

    def handle(self):
        self.request.sendall(b"lol")

def run(host=HOST, port=PORT, server_class=server.HTTPServer, handler_class=LolHandler):
    server_address = (host, port)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()

run()
