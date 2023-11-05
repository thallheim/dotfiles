# thallheim dotfiles

Personal dotfiles.

Only implemented for Emacs (and only partially) while the updater script is unfinished.

*Subject to breaking changes without warning*


# TODO

- [ ] Main copy ops
- [ ] Decide what needs refactoring into a settings file
- [ ] Do `pushd` & `popd` on start and end of run
- [ ] Allow dry-run
- [x] List input handling
- [ ] Nested list input handling
- [x] Rewrite pre-op file checks
   - [ ] Time first or diff first?
   - [ ] Ask whether to proceed if not all sources could be verified
- [ ] Allow multiple inclusion sources
- [ ] Allow flag to display full paths (i.e 'don't strip slugs')
- [ ] Write help string(s)
- [x] Allow error verbosity flag
	- [ ] Rework after 'proper' arg parsing is implemented
- [x] Transform absolute paths from `verify_src_paths` (i.e 'home/blah/..' -> '~/..')

# CHANGELOG

*- 0.0.1
  Init
