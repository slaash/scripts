#!/usr/bin/ruby

require 'gtk2'

window=Gtk::Window.new("Main app")

vbox = Gtk::VBox.new false, 5
valign = Gtk::Alignment.new 0, 1, 0, 0
vbox.pack_start valign

ok = Gtk::Button.new "OK"
ok.set_size_request 70, 30
vbox.add(ok)


hbox = Gtk::HBox.new(true,3)

halign = Gtk::Alignment.new(1,0,0,0)
halign.add(hbox)

vbox.pack_start halign, false, false, 3

window.add(vbox)

menubar=Gtk::MenuBar.new
hbox.add(menubar)
menubar.show

button = Gtk::Button.new("Hello World")
window.add(button)
button.show

button.signal_connect('clicked') {
  print "Hello World\n"
}

file_menu = Gtk::Menu.new
open_item = Gtk::MenuItem.new("Open")
quit_item = Gtk::MenuItem.new("Quit")
file_menu.append( open_item )
file_menu.append( quit_item )
open_item.show
quit_item.show

help_menu = Gtk::Menu.new
about_item = Gtk::MenuItem.new("About")
help_menu.append( about_item )
about_item.show

filemenu=Gtk::MenuItem.new("File")
filemenu.show
filemenu.set_submenu(file_menu)
menubar.append(filemenu)

helpmenu=Gtk::MenuItem.new("Help")
helpmenu.show
helpmenu.set_submenu(help_menu)
menubar.append(helpmenu)

window.signal_connect("destroy"){
	puts "Exiting..."
	Gtk.main_quit
}

window.set_default_size(400,200)

window.show_all

Gtk.main

