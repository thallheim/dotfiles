# thallheim dotfiles

Personal dotfiles.

Only implemented for Emacs and tmux (and only partially) while the updater script is
unfinished.

*Subject to breaking changes without warning*



# TODO

*Roughly* in order of priority.

- [ ] Add a function to check the error arrays at the end of all runs
- [ ] Decide what needs refactoring into a settings file
- [ ] Write newer/older check for copy ops
- [ ] Allow multiple inclusion sources
	- [ ] Nested list input handling (i.e "per-app" lists and dir trees)
- [x] Rewrite pre-op file checks
   - [ ] Time first or diff first?
   - [ ] Ask whether to proceed if not all sources could be verified
	   - *With flag; default off?*
	   - [ ] Add to user settings when that's working
- [ ] Rename and fork off updater & man generator
- [ ] Allow error verbosity levels
	- [ ] Rework after 'proper' arg parsing is implemented
- [ ] Allow saving existing target root as `dir.old/`
	- Allow setting for gzip if repo is large enough to warrant compression?
- [ ] Let user keep a machine/account-local ignore file that matches against
the include list, suppressing warnings about those files not being on the local
machine
- [ ] Do `pushd` & `popd` on start and end of run
	- Try to find out if it'll ever be necessary first. *Upd.:* Probably not :)
- [x] Main copy ops

-------------------------------------------------------------------------------
#### Implemented, needing additions

##### Write help string(s)
  * [ ] Sort out the 'real' globals in `functions.sh`. Some should be made
	  _actually_ global to the main runner

# CHANGELOG

##### 0.0.1
	Init
