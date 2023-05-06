#!/bin/sh -e


echo "Checking parens..."
${EMACS:=emacs} -nw --batch -Q \
		        --eval "(progn
                        (find-file \"init.el\")
                        (check-parens))"
echo "No formatting issues"

echo "Attempting startup..."
${EMACS:=emacs} -nw --batch \
                --eval '(progn
                        (defvar url-show-status)
                        (let ((debug-on-error t)
                              (url-show-status nil)
                              (user-emacs-directory default-directory)
                              (user-init-file (expand-file-name "init.el"))
                              (load-path (delq default-directory load-path)))
                           (load-file user-init-file)
                           (run-hooks (quote after-init-hook))
			   (all-the-icons-install-fonts t)
			   (nerd-icons-install-fonts t)))'

echo "Startup successful"
