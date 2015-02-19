#!/usr/bin/ruby -w

require 'Qt4'
 
Qt::Application.new(ARGV) do
    Qt::Widget.new do
 
        self.window_title = 'Hello QtRuby v1.0'
        resize(200, 100)
 
        button = Qt::PushButton.new('Quit') do
            connect(SIGNAL :clicked) { Qt::Application.instance.quit }
        end
 
        label = Qt::Label.new('<big>Hello Qt in the Ruby way!</big>')
 
        self.layout = Qt::VBoxLayout.new do
            add_widget(label, 0, Qt::AlignCenter)
            add_widget(button, 0, Qt::AlignRight)
        end
 
        show
    end
 
    exec
end

