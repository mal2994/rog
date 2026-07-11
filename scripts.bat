REM don't run this file, just copy and paste

REM you can then click on src/Main.elm to compile. Ctrl-r to pick up new changes.
elm reactor
REM since I am relying on CSS for custom fonts, it is handy to bring in elm-watch to hot reload everything. Pretty much works like nodemon.
npx elm-watch hot

elm-test --watch tests\MainTest.elm

elm repl

git add -u
git commit -m "hello"

REM elm reactor is on port 8000 i dont really use it anymore. VS Code Live Preview runs on 3000 and YOU HAVE TO MANUALLY RESTART IT if you make html changes. Not sure why live preview would need restarted LOL.
REM I've been trying to add a custom font, so to get a permanent index.html to edit, I've been building to a js file instead of the default index.html
REM elm make src/Main.elm --output=rog.js

REM https://fontdrop.info/
REM see glyphs from there