{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}

module Data.TimeSeries.IO.CSVReader
    ( loadCSV
    )where


import qualified Data.ByteString.Lazy as BS
import qualified Data.Text as T
import           Data.Csv
import qualified Data.Vector as V
import           Data.Time (UTCTime)

import           Data.TimeSeries.Series ( Series
                                        , emptySeries
                                        , series
                                        )


-- | Load data from CSV file and create Time Series from it
-- As a first argument provide function to convert date from ByteString to UTCTime
loadCSV :: Bool -> (T.Text -> UTCTime) -> FilePath -> IO Series
loadCSV hasHeader ft filePath = do
    csvData <- BS.readFile filePath
    let h = if hasHeader then HasHeader else NoHeader
    case decode h csvData of
        Left err -> do
            _ <- putStrLn err
            return emptySeries

        Right vs -> do
            let vs' = V.map (parseLine ft) vs
            return $ series (V.toList vs')


parseLine :: (T.Text -> UTCTime) -> (T.Text, Double) -> (UTCTime, Double)
parseLine ft (date, value) = (ft date, value)