#!/usr/bin/env runhaskell
{-
A segment of a list xs of length n is any sublist of the form xs[i · · · (j − 1)], with 0 ⩽ i ⩽ j ⩽ n.
(In case i = j, the segment is the empty list.)
Write a program
segments :: [a] -> [[a]]
that produces all the segments in a given list. (The order in which the segments are to be listed is indicated by the sample cases below. Notice that the empty list is included only once, but other lists can repeat, as the third example below shows:)
-}
