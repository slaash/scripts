from google.appengine.api import users
from google.appengine.ext import webapp
import webapp2

providers = {
    'Google'   : 'https://www.google.com/accounts/o8/id',
    'Yahoo'    : 'yahoo.com',
    'MySpace'  : 'myspace.com',
    'AOL'      : 'aol.com',
    'MyOpenID' : 'myopenid.com'
    # add more here
}

class MainHandler(webapp.RequestHandler):
    def get(self):
        user = users.get_current_user()
        if user:  # signed in already
            self.response.out.write('Hello <em>%s</em>! [<a href="%s">sign out</a>]' % (
                user.nickname(), users.create_logout_url(self.request.uri)))
        else:     # let user choose authenticator
            self.response.out.write('Hello world! Sign in at: ')
            for name, uri in providers.items():
                self.response.out.write('[<a href="%s">%s</a>]' % (
                    users.create_login_url(federated_identity=uri), name))

application = webapp2.WSGIApplication([('/', MainHandler),], debug=True)

