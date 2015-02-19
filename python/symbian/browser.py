import appuifw
import e32
import os
 
class FileBrowser:
    def __init__(self):
        self.entries = e32.drive_list()
        self.path = []
 
    def update_entries(self):
        if self.path:
            self.entries = os.listdir(os.path.join(*self.path))
            self.entries.insert(0, u'..')
        else:
            self.entries = e32.drive_list()
 
    def run(self):
        opt = 0
        while opt is not None:
            opt = appuifw.selection_list(self.entries)
            if opt is not None:
                if opt == 0 and self.path:
                    self.path.pop()
                else:
                    self.path.append(self.entries[opt])
                    if not os.path.isdir(os.path.join(*self.path)):
                        return os.path.join(*self.path)
                self.update_entries()

selected_file = FileBrowser().run()

