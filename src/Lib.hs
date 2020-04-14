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

getDivisor :: Int -> Int
getDivisor num = 
    case num of
        5 -> 10000
        4 -> 1000
        3 -> 100
        2 -> 10
        1 -> 1
        _ -> num

getTens :: Int -> String
getTens numInt = 
    case numInt of
        10 -> "Ten"
        9 -> "Nine"
        8 -> "Eight"
        7 -> "Seven"
        6 -> "Six"
        5 -> "Five"
        4 -> "Four"
        3 -> "Three"
        2 -> "Two"
        1 -> "One"

getStr :: Int -> String
getStr num = show num

getLength :: Str -> Int
getLength anyStr = length anyStr :: Int

computeNumberWord :: Int -> Int -> String
computNumberWord numInt numLen = 
    if remainderLen > 1
        then computeNumberWord (remainder remainderLen)
        else getTens remainderStr
    where
        divisor = getDivisor numLen
        remainder  = numInt % divisor
        remainderStr = show remainder
        remainderLen = length remainderStr :: Int

getNumberWord :: String -> String
getNumberWord numStr = 
    computeNumberWord (numInt numLen)
    where
        numInt = read numStr :: Int
        numLen = length numStr :: Int

caseMatchCallback :: Server.Request -> Server.Response
caseMatchCallback req = 
    Server.stringResponse (Debug.traceShowId (getNumberWord x))
    where 
        x = Server.requestBody req


someFunc :: IO ()
someFunc = Server.startServer [
    helloHandler, echoHandler,
    Server.simpleHandler Server.POST "/case" caseMatchCallback]


