REM don't run this file, just copy and paste
REM elm reactor port 8000, http-server port 8080, live server port 3000. Sometimes need to restart live server.

REM ELM REACTOR
REM Not Using Anymore Due To Lack Of Styling/Custom Fonts. See Elm-Watch...
REM you can click on src/Main.elm to compile. Ctrl-r to pick up new changes.
elm reactor

REM ELM-WATCH
REM builds the project whenever elm files change
npx elm-watch hot

REM ELM-TEST
REM type checks and tests code whenever files change
elm-test --watch tests

REM ELM REPL
REM run some code interactively
elm repl

REM GIT
git add -u
git commit -m "hello"

REM ELM MAKE
REM DO NOT RUN `elm make` DIRECTLY! It will overwrite your `index.html` !!!
REM Elm-Watch should be taking care of building...
REM elm make src/Main.elm --output=rog.js

REM https://fontdrop.info/
REM see glyphs from there