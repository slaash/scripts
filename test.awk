#!/usr/bin/awk

{ print gensub(/(.+)([0-9]{3})/, "\\1.\\2", "g") }
