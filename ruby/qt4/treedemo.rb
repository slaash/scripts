#!/usr/bin/ruby -w

=begin
**
** treedemo.rb
** 02/JUN/2007
** Daniel Martin Gomez
**
** Desc:
**  This script shows how to use the Qt::TreeWidget object. It populates a tree
**  using filesystem directory information. Please note that this should only
**  be used as an usage example of the widget. See Qt::DirModel for
**  implementing directory tree behaviour.
**
** Version:
**  v1.0 [02/Jun/2007]: first released
**
** This file may be used under the terms of the GNU General Public
** License version 2.0 as published by the Free Software Foundation
** and appearing in the file LICENSE.GPL included in the packaging of
** this file.  Please review the following information to ensure GNU
** General Public Licensing requirements will be met:
** http://www.trolltech.com/products/qt/opensource.html
**
=end

#require Qt4 bindings for ruby
require 'Qt4'

$DEFAULT_PATH = '/home/slash'


#populate the tree
def populate(tree, path, parent=nil)
  Dir["#{path}/*"].each do |file|
    #fill item information
    item = Qt::TreeWidgetItem.new()
    item.setText(0, File.basename(file))
    item.setText(1, File.mtime(file).strftime("%Y-%m-%d %I:%M:%S %p"))
    item.setText(2, (File.size(file).to_s + ' bytes'))
    item.setText(3, File.dirname(file) + '/')
    item.setIcon(0, Qt::Icon.new(File.ftype(file)) )

    #add item to the tree
    if (parent == nil)
      tree.addTopLevelItem(item)
    else
      parent.insertChild(parent.childCount, item)
    end

    if (File.ftype(file) == 'directory')
      populate(tree, file, item)
    end
  end
end

if $0 == __FILE__
  #parse command line
  if (ARGV.size > 0)
    path = ARGV[0]
  else
    path = $DEFAULT_PATH
  end



  app = Qt::Application.new(ARGV)
  tree = Qt::TreeWidget.new
  tree.windowTitle = "Simple Tree Example"
  
  #set view headers
  tree.setHeaderLabels(['File Name', 'Last Modified', 'Size', 'Path'])
  populate(tree,path)
  
  tree.show
  app.exec
end
