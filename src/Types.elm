module Types exposing (..)

import Browser exposing (UrlRequest)
import Browser.Navigation exposing (Key)
import Lamdera exposing (ClientId, SessionId)
import Set exposing (Set)
import Url exposing (Url)


type SharedState
    = Lobby Int
    | NotLobby


type alias FrontendModel =
    { key : Key
    , message : String
    , serverState : Maybe SharedState
    }


type alias BackendModel =
    { message : String
    , clients : Set ClientId
    }


type FrontendMsg
    = UrlClicked UrlRequest
    | UrlChanged Url
    | NoOpFrontendMsg


type ToBackend
    = NoOpToBackend


type BackendMsg
    = NoOpBackendMsg
    | ClientConnected SessionId ClientId


type ToFrontend
    = ServerState SharedState
