from pyramid.view import view_config
from pyramid.response import Response
import logging
import json
from smtplib import SMTP
from email.mime.text import MIMEText
from multiprocessing import Process, Queue
from time import sleep
from subprocess import check_output
from os import environ
import re

def _queWatcher():
    logging.info("Queue watcher started")
    clair = environ.get('CLAIR_HOST', 'clair')
    pattern = re.compile(r'.+@(uberresearch|digital-science)\.com')
    cc = 'radu@uberresearch.com'
    while True:
        while imageQueue.qsize() > 0:
            item = imageQueue.get()
            logging.info("Watcher got: {} {} {} ({} items in queue)".format(item[0], item[1], item[2], imageQueue.qsize()))
            try:
                docker_pull = check_output(['docker', 'pull', 'docker.uberresearch.com/{}:{}'.format(item[0], item[1])])
                logging.info("docker pull:\n{}".format(docker_pull.decode("utf-8")))
                result = check_output(['analyze-local-images', '-minimum-severity', 'High', 'docker.uberresearch.com/{}:{}'.format(item[0], item[1])])
                user = item[2]
                result = result.decode("utf-8") + "\n\nImage pushed by " + user
                if not pattern.match(user):
                    user = ''
                logging.info("Sending email(s) to [{}, {}]".format(user, cc))
                _sendmail('[CLAIR SCAN]: docker.uberresearch.com/{}:{}'.format(item[0], item[1]), 'root@uberresearch.com', [user, cc], result)
            except Exception as err:
                logger.info(err)
        sleep(1)
    logging.info("Bye bye watcher")

def _sendmail(subject, src, dest, content):
    message = MIMEText(content)
    message['Subject'], message['From'], message['To'] = subject, src, ", ".join(dest)
    mailServer = environ.get('SMTP_HOST', 'mail')
    try:
        sm = SMTP(mailServer)
        sm.sendmail(src, dest, message.as_string())
        sm.quit()
    except Exception as err:
        logger.info(err)

@view_config(route_name='home', renderer='templates/mytemplate.pt')
def my_view(request):
    return {'project': 'var_test'}

@view_config(route_name='event')
def getDockerEvent(request):
    body = request.body.decode("utf-8")
    try:
        data = json.loads(body)
    except ValueError as err:
        logger.info(err)
        return Response(status='404')
    if data['events'][0]['action'] == 'push' and data['events'][0]['request']['method'] == 'PUT' and 'tag' in data['events'][0]['target']:
        time = data['events'][0]['timestamp']
        repo = data['events'][0]['target']['repository']
        tag = data['events'][0]['target']['tag']
        name = data['events'][0]['actor']['name']
        logger.info("{}: {} pushed {}:{}".format(time, name, repo, tag))
        imageQueue.put([repo, tag, name])
        logging.info("getDockerEvent: image queue size: {}".format(imageQueue.qsize()))
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
        logging.info("scanImage: image queue size: {}".format(imageQueue.qsize()))
        return Response(status=200)

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)
imageQueue = Queue()
watch = Process(target=_queWatcher)
watch.start()

