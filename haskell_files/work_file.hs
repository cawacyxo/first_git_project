import System.IO 
import System.Environment

main :: IO ()

main = do
    [arg1,arg2] <- getArgs
    src <- readFile arg1
    res <- return (operate src)
    _ <- writeFile arg2 res
    return ()

operate :: String -> String
operate x = x

getname = putStrLn ("Enter name: ") >> getLine >>= putStrLn . ("Hi" ++)
