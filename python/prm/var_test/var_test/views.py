from pyramid.view import view_config
from pyramid.response import Response
import json

@view_config(route_name='home', renderer='templates/mytemplate.pt')
def my_view(request):
    return {'project': 'var_test'}

@view_config(route_name='event')
def getDockerEvent(request):
    print(request.body.decode("utf-8"))
    return Response(status=200)
