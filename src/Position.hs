module Position where

type Point = (Double, Double)
type PointSet = (Point, Point, Point, Point)
type Intensity = Double
type Raw = (Intensity, Intensity, Intensity, Intensity)
type Distance = Double
type Distances = (Distance, Distance, Distance, Distance)

calcPoint :: Raw -> Point
calcPoint r = centroid(getCorners(convertToDistances r))

convertToDistances :: Raw -> Distances
convertToDistances r = mapQuadruple convertToDistance r

convertToDistance :: Intensity -> Distance
convertToDistance i = (1-i)*sqrt(2)

getCorners :: Distances -> PointSet
getCorners (on, to, th, fo) = (revolveSystem (duangulate to on) 0,
	revolveSystem (duangulate th to) 1,
	revolveSystem (duangulate fo th) 2, 
	revolveSystem (duangulate on fo) 3)

--Katheten + Höhensatz
duangulate :: Distance -> Distance -> Point
duangulate a b = (calcX a b, calcY b (calcX a b))

calcX :: Distance -> Distance -> Double
calcX a b = (b^2 + 1^2 - a^2) / (2 * 1)

calcY :: Distance -> Double -> Double
calcY b x = sqrt(b^2 - x^2)

revolveSystem :: Point -> Int -> Point
revolveSystem (x, y) 0 = (x, y)
revolveSystem (x, y) i = revolveSystem ((1-y), x) (i-1)

centroid :: PointSet -> Point
centroid ((xa, ya), (xb, yb), (xc, yc), (xd, yd)) = (((xa+xb+xc+xd)/4),((ya+yb+yc+yd)/4))

mapQuadruple :: (a -> b) -> (a, a, a, a) -> (b, b, b, b)
mapQuadruple f (a1, a2, a3, a4) = (f a1, f a2, f a3, f a4)

pointSetArea :: PointSet -> Double
pointSetArea (a, b, c, d) = polygonArea [a,b,c,d] 0

pointSetCentroid :: PointSet -> Point
pointSetCentroid (a, b, c, d) = (polygonCentriodX [a,b,c,d] 0 (pointSetArea (a,b,c,d)), polygonCentriodY [a,b,c,d] 0 (pointSetArea (a,b,c,d)))

polygonArea :: [Point] -> Double -> Double
polygonArea (p:[])                 s = 0.5 * s
polygonArea ((x0, y0):(x1, y1):ps) s = polygonArea ((x1, y1):ps) (s+x0*y1-x1*y0)

polygonCentriodX :: [Point] -> Double -> Double -> Double
polygonCentriodX (p:[])                 s a = s/(6*a)
polygonCentriodX ((x0, y0):(x1, y1):ps) s a = polygonCentriodX ((x1, y1):ps) (s+(x0+x1)*(x0*y1-x1*y0)) a

polygonCentriodY :: [Point] -> Double -> Double -> Double
polygonCentriodY (p:[])                 s a = s/(6*a)
polygonCentriodY ((x0, y0):(x1, y1):ps) s a = polygonCentriodX ((x1, y1):ps) (s+(y0+y1)*(x0*y1-x1*y0)) a