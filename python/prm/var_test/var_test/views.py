from pyramid.view import view_config
from pyramid.response import Response
import logging
import json
from smtplib import SMTP
from email.mime.text import MIMEText
from queue import Queue
from multiprocessing import Process

def _queWatcher():
    logging.info("Queue watcher started")
    while True:
        while imageQueue.qsize() > 0:
            item = imageQueue.get()
            logging.info("Watcher got: {} {} {}".format(item))
    logging.info("Bye bye watcher")

def _sendmail(subject,src,dest,content):
    message = MIMEText(content)
    message['Subject'], message['From'], message['To'] = subject, src, dest
    try:
        sm = smtplib.SMTP('mail')
        sm.sendmail(args.src, args.dest, message.as_string())
        sm.quit()
    except Exception as err:
        logger.info(err)

@view_config(route_name='home', renderer='templates/mytemplate.pt')
def my_view(request):
    return {'project': 'var_test'}

@view_config(route_name='event')
def getDockerEvent(request):
    body = request.body.decode("utf-8")
    logger.info(body)
    try:
        data = json.loads(body)
    except ValueError as err:
        logger.info(err)
        return Response(status='404')
    if data['events'][0]['action'] == 'push':
        time = data['events'][0]['timestamp']
        repo = data['events'][0]['target']['repository']
        if 'tag' in data['events'][0]['target']:
            tag = data['events'][0]['target']['tag']
        else:
            tag = 'latest'
        name = data['events'][0]['actor']['name']
        logger.info("{}: {} pushed {}:{}".format(time, name, repo, tag))
    return Response(status=200)

@view_config(route_name='scan', request_method='GET')
def scanImage(request):
    repo = request.matchdict.get('repo', '')
    tag = request.matchdict.get('tag', '')
    user = request.matchdict.get('user', '')
    logger.info("Got scan request for {}:{} from {}".format(repo, tag, user))
    if repo == '' or tag == '':
        return Response(status='404')
    else:
        imageQueue.put([repo, tag, user])
        logging.info("Image queue size: {}".format(imageQueue.qsize()))
        return Response(status=200)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)
imageQueue = Queue()
watch = Process(target=_queWatcher)
watch.start()

