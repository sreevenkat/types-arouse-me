module Lib ( someFunc )where

import qualified Zero.Server as Server

helloHandler :: Server.Handler
helloHandler = 
    Server.simpleHandler Server.GET "/hello" helloCallback

helloCallback :: Server.Request -> Server.Response
helloCallback req = 
    Server.stringResponse "hello"


someFunc :: IO ()
someFunc = Server.startServer [helloHandler]


