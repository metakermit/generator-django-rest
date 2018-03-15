import os

bind = '0.0.0.0:8000'
workers = int(os.environ.get('WEB_WORKERS', '3'))
timeout = int(os.environ.get('WEB_TIMEOUT', '30'))
worker_class = os.environ.get('WEB_WORKER', 'sync') #recommended: eventlet
reload = os.environ.get('DEBUG', '').upper() in ('1', 'TRUE')
preload_app = False

if worker_class == 'gevent':
    import gevent.monkey
    gevent.monkey.patch_thread()


def post_fork(server, worker):
    if worker_class == 'gevent':
        from psycogreen.gevent import patch_psycopg
        patch_psycopg()
