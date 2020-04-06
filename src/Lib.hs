module Lib ( someFunc )where

import qualified Zero.Server as Server
import qualified Debug.Trace as Debug

helloHandler :: Server.Handler
helloHandler = 
    Server.simpleHandler Server.GET "/hello" helloCallback

helloCallback :: Server.Request -> Server.Response
helloCallback req = 
    Server.stringResponse "hello"

echoHandler :: Server.Handler
echoHandler = Server.simpleHandler Server.POST "/echo" echoCallback

echoCallback :: Server.Request -> Server.Response
echoCallback req = 
    Server.stringResponse (Server.requestBody req)

getNumberWord :: String -> String
getNumberWord num = 
    case num of
        "1" -> "one"
        "2" -> "two"
        "3" -> "three"
        _ -> "whoops"

caseMatchCallback :: Server.Request -> Server.Response
caseMatchCallback req = 
    Server.stringResponse (Debug.traceShowId (getNumberWord x))
    where 
        x = Server.requestBody req


someFunc :: IO ()
someFunc = Server.startServer [
    helloHandler, echoHandler,
    Server.simpleHandler Server.POST "/case" caseMatchCallback]


