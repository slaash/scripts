from pyramid.config import Configurator
import os.path


def main(global_config, **settings):
    """ This function returns a Pyramid WSGI application.
    """
    config = Configurator(settings=settings)

    print(config.registry.settings['config.store'])
    print(os.path.expandvars(config.registry.settings['config.store']))

    config.include('pyramid_chameleon')
    config.add_static_view('static', 'static', cache_max_age=3600)
    config.add_route('home', '/')
    config.scan()
    return config.make_wsgi_app()
