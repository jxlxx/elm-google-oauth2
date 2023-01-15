# Google OAuth 2.0 with Elm

This repo contains slightly more than the minimum required code to authenticate with google in an Elm app.
The token id is saved in a cookie but in this example app the elm side of things does not know that. 

To do authentication with google in Elm, you need to use ports + js interop. 

To implement this in your own projects, you need:

1. A [Google Client ID](https://support.google.com/cloud/answer/6158849);

It looks something like: `789723491626-6p01agh94gidiaesvev5saq6c6a30fmn.apps.googleusercontent.com`

2. HTML for the Google button in your `html/js` (see [Google's code generator](https://developers.google.com/identity/gsi/web/tools/configurator));

It looks like:
```html
<div id="g_id_onload"
   data-client_id="789723491626-6p01agh94gidiaesvev5saq6c6a30fmn.apps.googleusercontent.com"
   data-context="signup"
   data-ux_mode="popup"
   data-callback="handleCallBack"
   data-auto_prompt="false">
</div>
  
<div class="g_id_signin"
   data-type="standard"
   data-shape="rectangular"
   data-theme="outline"
   data-text="signin_with"
   data-size="large"
   data-logo_alignment="left">
</div>
```
You could also just use the code in the above with your client id.

3. A port and a subscriber in your Elm code.

See `src/Main.elm`.

4. A handler function in your html/js to send data to your Elm code.

Like this:

```js
window.handleCallBack = (data) => {
  app.ports.googleSignIn.send(data.credential)
}
```

(the `window` part is important)


# Running the example

To run the code all you need is `elm` and `elm-live`. (`elm reactor` will **not** work).

Note that you will also need to update the Google Client ID in both `index.html`, otherwise you will always get an error that the client id is not found.

```
elm-live src/Main.elm -- --output=main.js
```

# A note on google client ids

If you are testing this locally, when you create your OAuth 2.0 Client ID, you probably have to add
`http://localhost` AND `http://localhost:8000`
(or what ever port you are using) to both:

1. Authorized JavaScript Origins
2. Authorized redirect URIs

And you can make it external.

And you can userinfo + email scopes to get the users name/email if you wish.





