module UI where

import Position
import System.IO
import Data.Maybe

printPoint :: Point -> IO ()
printPoint p = do
	putStrLn (show(p))

readRaw :: IO (Maybe Raw)
readRaw = do
	let base = "../../anticipator-input/"
	one <- readInput 1
	let parsedOne = readIntensity (one)
	two <- readInput 2
	let parsedTwo = readIntensity two
	three <- readInput 3
	let parsedThree = readIntensity three
	four <- readInput 4
	let parsedFour = readIntensity four
	if isNothing(parsedOne) || isNothing(parsedTwo) || isNothing(parsedThree) || isNothing(parsedFour)
		then return Nothing
		else return (Just (fromJust parsedOne, fromJust parsedTwo, fromJust parsedThree, fromJust parsedFour))

readIntensity :: String -> Maybe Intensity
readIntensity s
	| (reads s::[(Intensity,String)]) /= [] = Just ((read (getFirstLine s))::Intensity)
	| otherwise = Nothing

getFirstLine :: String -> String
getFirstLine []     = []
getFirstLine (x:xs)
	| x == '\n' = []
	| otherwise = x : (getFirstLine xs)

--readInputs :: IO ((String, String, String, String))
--readInputs = do	
--	let base = "../../anticipator-input/"
--	one <- readFile (base ++ "1")
--	let parsedOne = readIntensity one
--	two <- readFile (base ++ "2")
--	let parsedTwo = readIntensity two
--	three <- readFile (base ++ "3")
--	putStrLn (three)
--	let parsedThree = readIntensity three
--	four <- readFile (base ++ "4")

--	h1 <- openFile (base ++ "1") ReadMode
--	one <- hGetLine h1
--	hClose h

readInput :: Int -> IO(String)
readInput s = do
	let base = "../../anticipator-input/"
	h <- openFile (base ++ (show s)) ReadMode
	end <- hIsEOF h
	if end
		then return ""
		else do
			one <- hGetLine h
			hClose h
			return one
