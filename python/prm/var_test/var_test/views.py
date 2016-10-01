from pyramid.view import view_config
from pyramid.response import Response
import logging
import json

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

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
        tag = data['events'][0]['target']['tag']
        name = data['events'][0]['actor']['name']
        logger.info("{}: {} pushed {}:{}".format(time, name, repo, tag))
    return Response(status=200)
