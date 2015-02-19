#!/usr/bin/python

from flask import Flask, render_template

app = Flask(__name__)
@app.route('/', defaults={'name': 'Flask'})
@app.route('/<name>')
def index(name):
	return render_template('hello.html',name=name)
if __name__ == '__main__':
	app.run(host='0.0.0.0')

