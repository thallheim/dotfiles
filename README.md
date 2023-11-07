# thallheim dotfiles

Personal dotfiles.

Only implemented for Emacs and tmux (and only partially) while the updater script is
unfinished.

*Subject to breaking changes without warning*


# TODO

*Roughly* in order of priority.

- [ ] Decide what needs refactoring into a settings file
- [ ] Allow multiple inclusion sources
	- [ ] Nested list input handling (i.e "per-app" lists and dir trees)
- [ ] Write newer/older check for copy ops
- [x] Rewrite pre-op file checks
   - [ ] Time first or diff first?
   - [ ] Ask whether to proceed if not all sources could be verified
	   - *With flag; default off?*
	   - [ ] Add to user settings when that's working
- [ ] Write help string(s)
- [ ] Allow output verbosity (bool)
- [ ] Allow error verbosity levels
	- [ ] Rework after 'proper' arg parsing is implemented
- [ ] Let user keep a machine/account-local ignore file that matches against
the include list, suppressing warnings about those files not being on the local
machine
- [ ] Do `pushd` & `popd` on start and end of run
	- Try to find out if it'll ever be necessary first.
- [x] Main copy ops

# CHANGELOG

##### 0.0.1
	Init
