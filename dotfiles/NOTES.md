# bash dot files

06/27/2021 There's some $PATH fucker going on that I don't fully understand yet.
I found out that when opening a terminal from the desktop here on Ubuntu 20.04 (Gnome?)

```
shopt -q login_shell
echo $?
1
```

So `.bash_profile` is not sourced. I am choosing to let the `bash_profile` in this repo remain,  but have commented everything out.
It gets installed but does nothing.

After reading [rwxrob's](https://github.com/rwxrob) path section more carefully, I uncommented the path functions he uses.
It seems like he doesn't use `bash_profile` for handling exported shell variables. The path scripts are a nice way of getting 
the path right (very important), albeit a bit obscure. Could probably use some comments for posterity. 



