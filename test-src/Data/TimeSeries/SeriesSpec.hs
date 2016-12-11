module Data.TimeSeries.SeriesSpec (spec) where

import qualified Data.TimeSeries as TS
import Test.Hspec


spec :: Spec
spec = do

  describe "Basic operations" $ do

    it "return series size" $ do
        let idx = [1, 2, 3]
        let values = [1.0, 2.0, 3.0]
        TS.size (TS.series idx values) `shouldBe` 3

    it "return data point value at given index" $ do
        let idx = [10, 20, 30]
        let values = [10.0, 12.0, 32.4]
        TS.valueAt (TS.series idx values) 20 `shouldBe` Just 12.0

    it "return Nothing value if wrong index" $ do
        let idx = [10, 20, 30]
        let values = [10.0, 12.0, 32.4]
        TS.valueAt (TS.series idx values) 1234 `shouldBe` Nothing

    it "return subset" $ do
        let xs = TS.series [1..5] [10.0, 1.2, 32.4, 0.65, 11.0]
        TS.size (TS.slice xs 2 3) `shouldBe` 2

    it "return empty subset" $ do
        let xs = TS.series [1..5] [10.0, 1.2, 32.4, 0.65, 11.0]
        TS.slice xs 12 34 `shouldBe` TS.series [] []

    it "maximum value" $ do
        let xs = TS.series [1..5] [10.0, 1.2, 32.4, 0.65, 11.0]
        TS.max xs `shouldBe` 32.4

    it "minimum value" $ do
        let xs = TS.series [1..5] [10.0, 1.2, 32.4, 0.65, 11.0]
        TS.min xs `shouldBe` 0.65
