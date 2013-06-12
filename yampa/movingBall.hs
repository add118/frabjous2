-- movingBall.hs
-- uses wxFruit to move a ball around the screen

{-# LANGUAGE Arrows #-}

module Main where

import WXFruit
import FRP.Yampa hiding (left, right, next)
import Control.Arrow hiding (left, right)
import qualified Graphics.UI.WX as WX

diameter = 2 * radius
radius = 100
screenSize = WX.sz 1000 1000


--lifted from paddle.hs (example in wxFruit)
bg :: WXPicture
bg = wxWithColor WX.white wxfill

--draws the ball
drawBall :: SF WX.Point WXPicture
drawBall = proc (WX.Point x y) -> do
	let ballArea = WX.rect (WX.Point (x - radius) (y - radius)) (WX.sz diameter diameter)
	let ballPic = wxWithColor WX.yellow $ wxPicFill $ wxellipse ballArea
	let screenPic = ballPic `wxPicOver` bg
	returnA -< screenPic
	
	
--top level GUI
movingBall :: WXGUI () ()
movingBall = wxHBox $ proc _ -> do
		mpos <- wxmouse -< ()
--		screenPic <- wxBoxSF (drSwitch drawBall) -< (mpos, drawBall)
		screenPic <- wxBoxSF drawBall -< mpos
		_ <- wxpicture (psize screenSize) -< ppic screenPic
		returnA -< ()

main :: IO ()
main = startGUI "Oli's Moving Ball" movingBall