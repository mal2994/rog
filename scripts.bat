REM don't run this file, just copy and paste

REM you can then click on src/Rog.elm to compile. Ctrl-r to pick up new changes.
elm reactor

elm-test --watch tests\RogTest.elm

elm repl

git add -u
git commit -m "hello"

