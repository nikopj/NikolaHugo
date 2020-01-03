---
title: "My auto-reload setup for writing LATEX documents in VIM"
date: 2020-01-03T01:17:30-05:00
draft: false
---

I'm so happy with my current LATEX workflow that I want to share it. It is actually 
quite a niche problem that it's solving because it's born out of using VIM as my 
editor (a command-line editor) and Firefox as my PDF viewer. I enjoy VIM as its keyboard 
shortcuts allow me to write without being slowed down by using a mouse. Firefox is 
my PDF viewer of choice because 1. I always have it open anyway, and 2. It has a clean UI 
with features I like such as a table of contents and printing. 

### My (Old) Setup:
- Windowing System: X11 (this becomes important for the reload script)
- Editor: VIM
- PDF Viewer: Firefox
- Compilation: **MANUAL**, using ``latexmk``

Manually compiling my LATEX document to preview my work involves to following 7 lines 
of keyboard strokes. It may not seem like a lot but it quickly gets annoying. 

```
:w                      # write file in VIM
Ctrl-Z                  # stop VIM and put to background
latexmk -pdf report.tex # compile to pdf
Alt-Tab                 # swtich to Firefox
Ctrl-R                  # reload tab
Alt-Tab                 # switch to Terminal
fg                      # bring VIM to foreground, continue with life
```

I knew there had to be a better way. My goal was to find a method of having my 
computer listen for file changes in my ``.tex`` file and automatically compile to PDF 
and reload the viewer. 

### Automatic Tab-Reload in Firefox using XDOTOOL:
Sadly Firefox doesn't currently support automatic reload of a tab based on local 
file change (I believe it used to have a plugin for this, however, it was removed 
due to security risks). A workaround for this is using 
``xdotool - a command line X11 automation tool``. For those of us on UNIX-based operating 
systems (I believe almost all of which use X11, or some variant which allows ``xdotool`` 
to work), this lets us interact with our windows 
from the command line. That means we can essentially automate our ``Ctrl-R`` and ``Alt-Tab`` 
key-strokes from before. After some skimming of the man page and stackoverflow I arrived at 
the following reload script that gets the job done.

My ``reload`` bash script:
```bash
#!/bin/sh
CURRENT_WID=$(xdotool getactivewindow)                     
WID=$(xdotool search --name "report.pdf - Mozilla Firefox")
xdotool windowactivate --sync $WID                         
xdotool key F5                                             
xdotool windowactivate $CURRENT_WID                        
```
In the first two lines of the above script we get the names of the current window 
(our terminal emulator) and the Firefox PDF window. We then switch focus to 
the PDF window with ``windowactivate`` and use the ``--sync`` argument to ensure 
we only run the next line after we're confirmed to be focused on the window. 
We then use ``xdotool`` to hit the ``F5`` key, equivalent to hitting ``Ctrl-R``. 
Finally we return focus to the command line.

Running the script via ``./reload`` will reload the current tab on the Firefox 
window that is viewing the file ``report.pdf``. Change the filename used in the script 
to your own accordingly. Don't forget to add execute permissions to the script by running 
``chmod +x reload``. All we have left to do is figure out how to run this script 
whenever our tex file is written to.

### Listening for File-Changes with ``entr`` and My New Setup:

We can then use the command line tool [``entr - run arbitrary commands when a 
file changes``](https://eradman.com/entrproject/) 
to continuously listen for any file changes to ``report.tex`` and run our ``reload`` script. 
The following line in bash does the trick:

```bash
ls report.tex | entr -ps 'latexmk -pdf report.tex; ./reload'
```

``ls`` lists information about ``report.tex`` and is piped into ``entr`` 
which listens for changes. The ``-p`` option tells ``entr`` to wait 
until the first change is noticed. The ``-s`` option allows us to 
give some shell commands in single-quotes, where we've opted to 
compile our tex file to pdf with ``latexmk`` and then run our ``reload`` script.
You can keep this command in another terminal window or run it in the background 
of your current one. I keep it running in the foreground of another TMUX pane  
to the side of my VIM pane so that I can see any error messages if 
they occur.

My new setup now consists of simply writing the above bash one-liner 
at the start of each editing session, opening my draft PDF in Firefox with 
``firefox report.pdf``, and then saving my work in VIM with ``:w`` whenever I want 
to update my preview. The compilation and PDF reload now happens automatically whenever 
I save my tex file!

### Future Work and Remarks:
- The ``reload`` script relies on the current tab being the PDF tab. 
A better implementation would reload the tab if it was in the background.
- Every time I start editing a new project I have to *manually* type in the 
little ``ls | entr`` bash one-liner. I should really put this into a script that 
just takes in a filename.
- Note that the ``entr`` documentation mentions the use of their own 
``reload-browser`` script. In testing it myself I found that it occasionally fails 
due to the lack of the ``--sync`` argument in the ``xdotool windowactivate`` command. 
It's also nice to write your own scripts so that you really understand what's going on!


