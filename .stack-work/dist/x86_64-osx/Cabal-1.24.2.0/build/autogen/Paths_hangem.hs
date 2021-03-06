{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_hangem (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/jasondeutsch/code/combinator/hangem/hangem/.stack-work/install/x86_64-osx/lts-8.9/8.0.2/bin"
libdir     = "/Users/jasondeutsch/code/combinator/hangem/hangem/.stack-work/install/x86_64-osx/lts-8.9/8.0.2/lib/x86_64-osx-ghc-8.0.2/hangem-0.1.0.0-JYEHObG7tCTCnJN2dgWihu"
dynlibdir  = "/Users/jasondeutsch/code/combinator/hangem/hangem/.stack-work/install/x86_64-osx/lts-8.9/8.0.2/lib/x86_64-osx-ghc-8.0.2"
datadir    = "/Users/jasondeutsch/code/combinator/hangem/hangem/.stack-work/install/x86_64-osx/lts-8.9/8.0.2/share/x86_64-osx-ghc-8.0.2/hangem-0.1.0.0"
libexecdir = "/Users/jasondeutsch/code/combinator/hangem/hangem/.stack-work/install/x86_64-osx/lts-8.9/8.0.2/libexec"
sysconfdir = "/Users/jasondeutsch/code/combinator/hangem/hangem/.stack-work/install/x86_64-osx/lts-8.9/8.0.2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hangem_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hangem_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "hangem_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "hangem_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hangem_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hangem_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
