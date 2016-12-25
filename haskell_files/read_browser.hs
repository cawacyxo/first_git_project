import Network.Browser
import Network.HTTP
import Network.URI

-- Creating function
-- This is all for test 

httpreq = do 
      rsp <- Network.Browser.browse $ do
                 setAllowRedirects True
                 setOutHandler $ const (return ())
                 request $ getRequest "http://www.rosettacode.org/"
 
      putStrLn $ rspBody $ snd rsp

