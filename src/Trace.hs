module Trace where

import Position

type Trace = [Point]

store :: Point -> Trace -> Trace
store p []      = p:[]
store p (x:xs)
	| p /= x    = checkDistance p (x:xs)
	| otherwise = x:xs

checkDistance :: Point -> Trace -> Trace
checkDistance p []                    = [p]
checkDistance (x1,y1) ((x2,y2):xs)
	| sqrt((x2-x1)^2+(x2-x1)^2) > 0.4 = [(x1,y1)]
	| otherwise                       = (x1,y1):((x2,y2):xs)
