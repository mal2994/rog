REM don't run this file, just copy and paste

REM you can then click on src/Rog.elm to compile. Ctrl-r to pick up new changes.
elm reactor
REM since I am relying on CSS for custom fonts, it is handy to bring in elm-watch to hot reload everything. Pretty much works like nodemon.
npx elm-watch hot

elm-test --watch tests\RogTest.elm

elm repl

git add -u
git commit -m "hello"

REM elm reactor serves code on 2 ports, did you know? 8000 is the dashboard and 3000 is index.html
REM I've been trying to add a custom font, so to get a permanent index.html to edit, I've been building to a js file instead of the default index.html
REM there's a chance 3000 is simply vs code lol
REM elm make src/Rog.elm --output=rog.js

REM https://fontdrop.info/
REM see glyphs from there