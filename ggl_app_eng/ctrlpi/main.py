import webapp2
from google.appengine.api import users
from google.appengine.ext import db
import time
import cgi
import json

class RPiCommands(db.Model):
	date = db.DateTimeProperty(auto_now_add = True)
	ip = db.StringProperty()
	nick = db.StringProperty()
	cmd = db.TextProperty()
	rez = db.TextProperty()
	data = db.BlobProperty()
	done = db.BooleanProperty()

class BaseHandler(webapp2.RequestHandler):

        def __init__(self, request, response):
                self.initialize(request, response)
                self.user = users.get_current_user()

        def dispatch(self):
                if (self.user):
                        super(BaseHandler, self).dispatch()
                else:
                        self.redirect(users.create_login_url(self.request.uri))

        def _print(self, txt):
                self.response.out.write(txt)
                self._br()

        def _hr(self):
                self.response.out.write('<hr/>' + "\n")

        def _br(self):
                self.response.out.write('<br/>' + "\n")

class MainHandler(BaseHandler):
	def get(self):
                now = time.ctime(time.time())
                self._print('{} - Hello {} ({}) ! - <a href=\'{}\'>LogOut</a>'.format(now, self.user.nickname(), self.user.email(), users.create_logout_url("/")))
                self._print("Your IP: " + self.request.remote_addr)
                self._print("Origin URL: " + self.request.url)
                self._hr()
                self._print('<form action="/addcmd" method="POST">')
		self._print('Command: <input type="text" name="cmd">&nbsp;<input type="submit" value="Save">')
		self._print('</form>')
		self._hr()

class RecordShowHandler(BaseHandler):
		def get(self, id):
			rez = RPiCommands.get_by_id(int(id))
			self._print("{} - {}({}): {} (Status={}) -> {}".format(rez.date, rez.nick, rez.ip, rez.cmd, rez.done, rez.rez))

class AddCmdHandler(BaseHandler):
        def post(self):
		cmd = cgi.escape(self.request.get('cmd'))
		if (len(cmd) == 0):
			self._print('You must enter a command!')
		else:	
			c = RPiCommands()
			c.ip = self.request.remote_addr
			c.nick = self.user.nickname()
			c.cmd = cmd
			c.done = False
			key = c.put()
			rez = RPiCommands.get(key)
			self._print("Link to command rezults <a href='{}'>here</a>.".format(webapp2.uri_for("record", id=key.id(), _full=True)))

        def get(self):
                self.post()

class RecordsListHandler(BaseHandler):
	def get(self):
		rez = db.GqlQuery("select * from RPiCommands order by date desc")
                for line in rez:
			self._print(json.dumps(line.cmd))
                        self._print("{} - {}({}): {} (Status={}) -> {}".format(line.date, line.nick, line.ip, line.cmd, line.done, line.rez ))
                        self._hr()

	def post(self):
		pass

app = webapp2.WSGIApplication([
        webapp2.Route('/', MainHandler),
	webapp2.Route('/addcmd', AddCmdHandler),
	webapp2.Route('/record', RecordsListHandler),
	webapp2.Route('/record/<id>', RecordShowHandler, 'record')
], debug=True)

