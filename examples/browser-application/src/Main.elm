port module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html exposing (Html, div, text)
import Html.Attributes as Attr exposing (property)
import Url
import Json.Encode as Encode exposing (string)


-- MAIN

main =
    Browser.application
        { init = init
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


port googleSignIn : (String -> msg) -> Sub msg

googleOAuthButton : Html msg
googleOAuthButton = div [ Attr.property "id" (Encode.string "google-oauth") ] []


-- MODEL

type alias Model =
    { token : Maybe String }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd msg )
init () _ _  =
    ({token = Nothing}, Cmd.none )


-- UPDATE

type Msg
    = SignInSuccess String
    | SignInFailure
    | LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SignInSuccess cred ->
            ( {model | token = Just cred }, Cmd.none )
        SignInFailure ->
            ( {model | token = Nothing }, Cmd.none )
        LinkClicked _ ->
            ( model, Cmd.none )
        UrlChanged _ ->
            ( model, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    googleSignIn (\a -> SignInSuccess a)


 -- VIEW

view : Model -> Browser.Document Msg
view model =
    { title = "Google OAuth 2.0 - Application"
    , body = 
        [ googleOAuthButton
        , case model.token of
            Just token ->
                text ("Your id token: " ++ token)
    
            Nothing ->
                text "You have not signed in yet."
        ]
    }




