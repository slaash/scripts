from pyramid.config import Configurator
from pyramid.paster import setup_logging
import os.path


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(settings=settings)
    print('Setting up logging')
    setup_logging(global_config['__file__'])


#    print(config.registry.settings['config.store'])
#    print(os.path.expandvars(config.registry.settings['config.store']))

    config.include('pyramid_chameleon')
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('home', '/')
    config.add_route('event', '/event')
    config.scan()
    return config.make_wsgi_app()
