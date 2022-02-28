module Main exposing (Msg(..), main)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Transitions


type alias Model =
    { isShowing : Bool
    , transitionCount : Int
    }


init : ( Model, Cmd Msg )
init =
    ( { isShowing = True
      , transitionCount = 0
      }
    , Cmd.none
    )


view : Model -> Html Msg
view model =
    div [ class "antialiased flex flex-col items-center gap-y-4 mt-14 mx-auto text-blue-900" ]
        [ h1 [ class "text-4xl font-bold text-blue-500" ]
            [ text "With TailwindCSS" ]
        , div [ class "text-2xl" ]
            [ span [] [ text "count: " ]
            , span [] [ text (String.fromInt model.transitionCount) ]
            ]
        , button
            [ onClick Toggle
            , class "px-2 py-1 bg-gray-300 rounded-md"
            ]
            [ text "Toggle" ]
        , img
            [ src "/logo.png"
            , style "width" "300px"
            ]
            []
            |> Transitions.transitions
            |> Transitions.withIsShowing model.isShowing
            |> Transitions.withEnter "transition-opacity duration-500"
            |> Transitions.withEnterFrom "opacity-0"
            |> Transitions.withEnterTo "opacity-100"
            |> Transitions.withOnEnter TransitionIncrease
            |> Transitions.withLeave "transition-opacity duration-500"
            |> Transitions.withLeaveFrom "opacity-100"
            |> Transitions.withLeaveTo "opacity-0"
            |> Transitions.withOnLeave TransitionIncrease
            |> Transitions.view
        ]


type Msg
    = Toggle
    | TransitionIncrease


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Toggle ->
            ( { model | isShowing = not model.isShowing }, Cmd.none )

        TransitionIncrease ->
            ( { model | transitionCount = model.transitionCount + 1 }, Cmd.none )


main : Program () Model Msg
main =
    Browser.document
        { init = \_ -> init
        , update = update
        , view =
            \model ->
                { title = "elm-template"
                , body = [ view model ]
                }
        , subscriptions = \_ -> Sub.none
        }
