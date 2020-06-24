# Lamdera type safety issue

This repository shows how it is possible to create a lamdera app which compiles but sends incorrect messages from backend to frontend.

Model is defined as following:

```elm
type ToFrontend
    = ServerState SharedState


type SharedState
    = Lobby Int
    | NotLobby

```

Then we are trying to broadcast the state to clients using this code: 

```elm
updateClients : Model -> Cmd BackendMsg
updateClients m =
    Lamdera.broadcast (Lobby (Set.size m.clients))
```

Which is incorrect, since it should be `SharedState (Lobby (Set.size m.clients))`, but the code compiles and we have undefined behaviour. The message from bakend is descoded as NotLobby shared state. 

You can see the behaviour in action by checking out this repository, running `lamdera live` and opening `http://localhost:8000` in the browser. 




Environment: 

```sh
Linux minty 5.3.0-59-generic #53~18.04.1-Ubuntu SMP Thu Jun 4 14:58:26 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
➜  lamdera-issue git:(master) ✗ lamdera --version
0.0.1-alpha8-0.19.0
➜  lamdera-issue git:(master) ✗ 
```
