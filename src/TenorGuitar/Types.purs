module TenorGuitar.Types where

import Prelude (negate)
import Data.Maybe (Maybe)

-- | a finger position on a string
-- | n < 0  : String is silent
-- | n == 0 : Open string is sounded
-- | N > 0  : string is fretted at this position
type FingerPosition = Int

-- | fingering is represented as an array of finger positions,
-- | one for each of the 4 strings
type Fingering = Array FingerPosition

-- | a fingered string
type FingeredString =
  { stringNumber :: Int
  , fretNumber :: FingerPosition
  }

-- | a barreé
type Barre =
  Maybe FingeredString

-- | The editable chord shape of the tenor guitar
type ChordShape =
  { name :: String -- the chord name
  , firstFretOffset :: Int -- which fret on the tenor guitar does fret 1 represent
  , barre :: Barre -- a barré at this fret from this string to
  -- the final string (4)
  , fingering :: Fingering -- the fingering
  }

data MouseAction
  = Barre FingeredString
  | OneFret FingeredString
  | NoFret

-- | the number of frets we display
displayedFretCount :: Int
displayedFretCount = 6

-- | an open string
open :: FingerPosition
open = 0

-- | a silent (unplayed) string
silent :: FingerPosition
silent = -1

-- | all the open strings
openStrings :: Fingering
openStrings =
  [ open, open, open, open ]

-- | and the chord that is therefore produced
openStringsChordName :: String
openStringsChordName =
  "C6/9"
