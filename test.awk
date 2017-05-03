#!/usr/bin/awk -f

{ print gensub(/(.+)([0-9]{3})/, "\\1.\\2", "g") }
