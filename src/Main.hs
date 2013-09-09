module Main where

import Position
import UI
import Trace
import Data.Maybe
import Control.Concurrent

main = do
	loop []


loop :: Trace -> IO()
loop xs = do
	r <- readRaw
	if isJust r
		then do
			if length xs < 99
				then do
					threadDelay 0
					loop (store (calcPoint (fromJust r)) xs)
				else do
					putStrLn (show xs)
					return ()
		else do
			loop xs