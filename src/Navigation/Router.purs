module Navigation.Router where

-- | The Router Halogen Component

import Prelude
import Data.Const (Const)
import Data.Maybe (Maybe(..), fromMaybe)
import Data.Either (hush)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH
import Navigation.Route (Route(..), routeCodec)
import Routing.Duplex as RD
import Routing.Hash (getHash)
import Navigation.Navigate (class Navigate, navigate)
import Guitar.Page as Guitar
import TenorGuitar.Page as TenorGuitar
import Bass.Page as Bass
import Piano.Page as Piano
import Home.Page as Home
import Type.Proxy (Proxy(..))

-- | When a component has no queries or messages, it has no public interface and can be
-- | considered an "opaque" component. The only way for a parent to interact with the component
-- | is by sending input.
type OpaqueSlot = H.Slot (Const Void) Void

type State =
  { route :: Maybe Route }

data Query a
  = Navigate Route a

data Action
  = Initialize

type ChildSlots =
  ( home :: OpaqueSlot Unit
  , guitar :: Guitar.Slot Unit
  , tenorguitar :: TenorGuitar.Slot Unit
  , bass :: Bass.Slot Unit
  , piano :: Piano.Slot Unit
  )

component :: ∀ m. MonadAff m => Navigate m => H.Component Query Unit Void m
component =
  H.mkComponent
    { initialState: \_ -> { route: Nothing }
    , render
    , eval: H.mkEval $ H.defaultEval
        { handleQuery = handleQuery
        , handleAction = handleAction
        , initialize = Just Initialize
        }
    }
  where

  handleAction :: Action -> H.HalogenM State Action ChildSlots Void m Unit
  handleAction = case _ of
    Initialize -> do
      -- we'll get the route the user landed on
      initialRoute <- hush <<< (RD.parse routeCodec) <$> H.liftEffect getHash
      -- and, finally, we'll navigate to the new route (also setting the hash)
      navigate $ fromMaybe Home initialRoute

  handleQuery :: forall a. Query a -> H.HalogenM State Action ChildSlots Void m (Maybe a)
  handleQuery = case _ of
    Navigate dest a -> do
      { route } <- H.get
      -- don't re-render unnecessarily if the route is unchanged
      when (route /= Just dest) do
        H.modify_ _ { route = Just dest }
      pure (Just a)

  render :: State -> H.ComponentHTML Action ChildSlots m
  render { route } = case route of
    Just r -> case r of
      Home ->
        HH.slot (Proxy :: _ "home") unit Home.component unit absurd
      Guitar ->
        HH.slot (Proxy :: _ "guitar") unit Guitar.component unit absurd
      TenorGuitar ->
        HH.slot (Proxy :: _ "tenorguitar") unit TenorGuitar.component unit absurd
      Piano ->
        HH.slot (Proxy :: _ "piano") unit Piano.component unit absurd
      Bass ->
        HH.slot (Proxy :: _ "bass") unit Bass.component unit absurd

    Nothing ->
      HH.div_ [ HH.text "Oh no! That page wasn't found." ]
