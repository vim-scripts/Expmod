Author: Mikolaj Machowski <mikmach@wp.pl>
Last change: nie sie 11 12:00  2002 C

Installation:
This is version for *nix systems. It can be easily modified for other
systems. Alas, it is rather impossible to create one cross-system
version since this plugin depends on external tools:
- xli for viewing graphic files (I believe it is in all systems with
  XFree)
- identify from ImageMagick package for image dimensions

expatch is a patch for regular explorer.vim
patch explorer.vim < expatch

expmod.vim is a plugin file. 
Drop it into your plugin directory.

Use:

expatch adds 2 new commands to explorer.vim: v and g
v - view graphic file
g - get full file name and store it in global variable

It works also with mouse and <Enter>:
v == <2-LeftMouse> == <Enter> (if file is graphic file)
g == <2-S-LeftMouse>

expmod.vim takes care about global variable. Behaviour of <F8> depends
on file name and file type of current buffer. The most dramatic effects
are if ft=html.
For graphic files it _o_pens new line and inserts:
<img src="relative_path" width="100" height="100" alt="short_file_name"
border="0">

relative_path is a relative path from edited file to graphic file. E.g.
"../images/alpha.gif"
dimensions are given by identify
short_file_name is short file name ;)
border is default value.

For all other files it inserts:
<a href="relative_path" class="">

<F8> works also for other 'ft' values:
For php: include("relative_path");
For c: #include <relative_path>
