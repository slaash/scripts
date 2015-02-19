#!/usr/bin/ruby -w

require 'Qt4'

a = Qt::Application.new(ARGV)
hello = Qt::PushButton.new("Hello World!")
hello.resize(100, 30)
hello.show
a.exec

