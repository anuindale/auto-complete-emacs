# auto-complete-emacs
simple emacs lisp script for auto-completion

Download myauto-complete.el and add the following lines to your init.el (aka .emacs) file:

(load-file "/...folder.../myauto-complete.el") 

(global-set-key (kbd "C-q") 'myauto-complete-mode)

USAGE:

1. Type some partial word or expression
2. C-q to highlight current partial word/expression
3. C-q again to jump to previous occurrences
4. C-j / C-l to adjust highlighting of previous occurrence
5. ENTER for auto-complete

OTHER:

After highlighting current partial word (Step 2), use left/right keys to adjust left boundary of word.
