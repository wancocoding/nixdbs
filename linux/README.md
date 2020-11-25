## Notice

if brew fail when install packages, like following

```
tar: /home/vincent/.cache/Homebrew/downloads/cfbf06524f7ea66e6023b765982938fa20659554b67b68b7fb8a157cf294
2d7--rust-1.47.0.x86_64_linux.bottle.tar.gz: Cannot open: No such file or directory
```
To fix that, run it manually, like this `brew install cmake`



### after install python

```
==> python@3.9
Python has been installed as
  /home/linuxbrew/.linuxbrew/bin/python3

Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
`python3`, `python3-config`, `pip3` etc., respectively, have been installed into
  /home/linuxbrew/.linuxbrew/opt/python@3.9/libexec/bin

You can install Python packages with
  pip3 install <package>
They will install into the site-package directory
  /home/linuxbrew/.linuxbrew/lib/python3.9/site-packages

See: https://docs.brew.sh/Homebrew-and-Python
```

