# Google OAuth 2.0 with Elm


## `Browser.element` vs `Browser.application`

To do authentication with google in Elm, you need to use ports + js interop, you cannot use pure Elm. This is becasue you have to add Google code/DOM elements to your page. To do this you can use either the [HTML API](https://developers.google.com/identity/gsi/web/reference/html-reference) or the [JS API](https://developers.google.com/identity/gsi/web/reference/js-reference).

If you are using something simple like a `Browser.element` you can use the HTML API. 
If you are using the HTML API, you can use [Google's code generator](https://developers.google.com/identity/gsi/web/tools/configurator), which is convienent.

If you are using a `Browser.application`, you will need to use the JS API, because you cannot directly add HTML because it will be overwritten. You will need to create a div in your elm code and add it to you view, and then call the JS API from your html/js to initialize the button once the window loads.


# Usage

To implement this in your own projects, you need:

1. A correctly configured [Google Client ID](https://support.google.com/cloud/answer/6158849)

2. An HTML element for the Google button (see the examples for specific details)

3. To import the Google API in your HTML, like this: `<script src="https://accounts.google.com/gsi/client" async defer></script>`

4. A port and a subscriber in your Elm code.

5. A handler function in your html/js to send data to your Elm code over the port. (Or an endpoint for google to redirect to
There is a commented out example of the redirect appraoch in the `browser-application` example, but currently they both implement the handler method).


# Running the examples

To run the code all you need is `elm` and `elm-live`. (`elm reactor` will not work in most cases).

Note that you will also need to update the Google Client ID in both `index.html`, otherwise you will always get an error that the client id is not found because I have deleted it.

## `elm make`
Before attempting to run the examples, compile the `js` with: `elm make src/Main.elm --outout=main.js`.

## `elm-live`
To run the `Browser.element` example, all you have to do is: `elm-live src/Main.elm -- --output=main.js`

To run the `Browser.application` example, the command is a little bit different because you need to let know `elm-live` know that you want the client to handle the routing. The command in this case is: `elm-live src/Main.elm --pushstate -- --output=main.js`.

## `shell.nix`
There is also a `shell.nix` file in this repo with some helpful scripts to build and run. So if you have `nix` installed you can just do `nix-shell` and you will have everything you need. 

You can build with: `elm-make`.

And run with: `elm-start`.

# A note on Client IDs

If you are testing this locally, when you create your OAuth 2.0 Client ID, you probably have to add:
`http://localhost` AND `http://localhost:8000`
(or what ever port you are using) to both:

1. Authorized JavaScript Origins
2. Authorized redirect URIs

And you can make it external (I think internal might just work if you have a google workspace). 

