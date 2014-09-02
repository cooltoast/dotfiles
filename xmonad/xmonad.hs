import XMonad
import XMonad.Config.Gnome
import XMonad.Util.Run
import XMonad.Util.EZConfig

main = do
    xmonad $ gnomeConfig
      { focusedBorderColor = myFocusedBorderColor 
      , modMask = myModMask
      } `additionalKeys` myExtraKeys

myFocusedBorderColor = "#3388ff"

myModMask = mod1Mask

myExtraKeys = 
  [
    ((mod, xK_g),
      safeSpawn "google-chrome" []
    )
  ]
  where mod = myModMask
