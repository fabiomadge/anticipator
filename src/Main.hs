module Main where

import Position
import UI
import Data.Maybe

main = do
	r <- readRaw
	if isJust r
		then printPoint(calcPoint(fromJust r))
		else putStrLn "Sorry"
	main