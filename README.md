# thallheim dotfiles

Personal dotfiles.

Only implemented for Emacs and tmux (and only partially) while the updater script is
unfinished.

*Subject to breaking changes without warning*


# TODO

*Roughly* in order of priority.

- [x] Allow output verbosity (bool)
	- Min. viable implemented
- [ ] Decide what needs refactoring into a settings file
- [ ] Write newer/older check for copy ops
- [ ] Allow multiple inclusion sources
	- [ ] Nested list input handling (i.e "per-app" lists and dir trees)
- [x] Rewrite pre-op file checks
   - [ ] Time first or diff first?
   - [ ] Ask whether to proceed if not all sources could be verified
	   - *With flag; default off?*
	   - [ ] Add to user settings when that's working
- [x] Write help string(s)
	- [**In progress**]
- [ ] Rename and fork off updater & man generator
- [ ] Allow error verbosity levels
	- [ ] Rework after 'proper' arg parsing is implemented
- [ ] Let user keep a machine/account-local ignore file that matches against
the include list, suppressing warnings about those files not being on the local
machine
- [ ] Do `pushd` & `popd` on start and end of run
	- Try to find out if it'll ever be necessary first. *Upd.:* Probably not :)
- [x] Main copy ops

# CHANGELOG

##### 0.0.1
	Init
