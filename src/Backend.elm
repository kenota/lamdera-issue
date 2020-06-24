module Backend exposing (..)

import Html
import Lamdera exposing (ClientId, SessionId)
import Set
import Types exposing (..)


type alias Model =
    BackendModel


app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub BackendMsg
subscriptions _ =
    Lamdera.onConnect ClientConnected


init : ( Model, Cmd BackendMsg )
init =
    ( { message = "Hello!", clients = Set.empty }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        NoOpBackendMsg ->
            ( model, Cmd.none )

        ClientConnected _ c ->
            let
                newModel =
                    { model | clients = Set.insert c model.clients }
            in
            ( newModel, updateClients newModel )


updateClients : Model -> Cmd BackendMsg
updateClients m =
    Lamdera.broadcast (Lobby (Set.size m.clients))


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    case msg of
        NoOpToBackend ->
            ( model, Cmd.none )
