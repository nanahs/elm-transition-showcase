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
        , myView
            |> Transitions.make
                { isShowing = model.isShowing
                , enter = "transition-opacity duration-500"
                , enterFrom = "opacity-0"
                , enterTo = "opacity-100"
                , onEnter = Just TransitionIncrease
                , leave = "transition-opacity duration-500"
                , leaveFrom = "opacity-100"
                , leaveTo = "opacity-0"
                , onLeave = Just TransitionIncrease
                }
            |> Transitions.view
        ]


myView : Html Msg
myView =
    img
        [ src "/logo.png"
        , style "width" "300px"
        ]
        []


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
