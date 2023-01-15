port module Main exposing (..)

import Browser
import Html exposing (Html, div, text)

-- MAIN

main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


port googleSignIn : (String -> msg) -> Sub msg


-- MODEL

type alias Model =
    { token : Maybe String }


init : () -> ( Model, Cmd msg )
init () =
    ({token = Nothing}, Cmd.none )


-- UPDATE

type Msg
    = SignInSuccess String
    | SignInFailure


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SignInSuccess cred ->
            ( {model | token = Just cred }, Cmd.none )
        SignInFailure ->
            ( {model | token = Nothing }, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    googleSignIn (\a -> SignInSuccess a)


 -- VIEW

view : Model -> Html Msg
view model =
    div []
    [ case model.token of
        Just token ->
            text ("Your id token: " ++ token)

        Nothing ->
            text "You have not signed in yet."
    ]




