//
//  Model.swift
//  CoinProject
//
//  Created by song on 2022/12/07.
//
import Foundation

//CoinGecko API info
/*
 URL : https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 */

protocol ImageDownloadableModel {
  var image: String { get }
  var imageURL: URL { get }
}

protocol SevenDaysHaveable {
  var sevenDatas: [Double] { get }
  var startPrice: Double { get }
  var endPrice: Double { get }
  var priceChange: Double { get }
}

struct CoinModel: Identifiable, Codable, ImageDownloadableModel, SevenDaysHaveable {
  
  let id, symbol, name: String
  let image: String
  let currentPrice: Double
  let marketCap, marketCapRank, fullyDilutedValuation, totalVolume: Double?
  let high24H, low24H, priceChange24H, priceChangePercentage24H: Double?
  let marketCapChange24H, marketCapChangePercentage24H: Double?
  let circulatingSupply, totalSupply, maxSupply, ath: Double?
  let athChangePercentage: Double?
  let athDate: String?
  let atl, atlChangePercentage: Double?
  let atlDate: String?
  let lastUpdated: String?
  let sparklineIn7D: SparklineIn7D?
  let priceChangePercentage24HInCurrency: Double?
  let currentHoldings: Double?
  
  enum CodingKeys: String, CodingKey {
    case id, symbol, name, image
    case currentPrice = "current_price"
    case marketCap = "market_cap"
    case marketCapRank = "market_cap_rank"
    case fullyDilutedValuation = "fully_diluted_valuation"
    case totalVolume = "total_volume"
    case high24H = "high_24h"
    case low24H = "low_24h"
    case priceChange24H = "price_change_24h"
    case priceChangePercentage24H = "price_change_percentage_24h"
    case marketCapChange24H = "market_cap_change_24h"
    case marketCapChangePercentage24H =  "market_cap_change_percentage_24h"
    case circulatingSupply = "circulating_supply"
    case totalSupply = "total_supply"
    case maxSupply = "max_supply"
    case ath
    case athChangePercentage = "ath_change_percentage"
    case athDate = "ath_date"
    case atl
    case atlChangePercentage = "atl_change_percentage"
    case atlDate = "atl_date"
    case lastUpdated = "last_updated"
    case sparklineIn7D = "sparkline_in_7d"
    case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
    case currentHoldings
  }
  
  
  func updateHoldings(amount: Double) -> CoinModel {
    return CoinModel(id: id,
                     symbol: symbol,
                     name: name,
                     image: image,
                     currentPrice: currentPrice,
                     marketCap: marketCap,
                     marketCapRank: marketCapRank,
                     fullyDilutedValuation: fullyDilutedValuation,
                     totalVolume: totalVolume,
                     high24H: high24H,
                     low24H: low24H,
                     priceChange24H: priceChange24H,
                     priceChangePercentage24H: priceChangePercentage24H,
                     marketCapChange24H: marketCapChange24H,
                     marketCapChangePercentage24H: marketCapChangePercentage24H,
                     circulatingSupply: circulatingSupply,
                     totalSupply: totalSupply,
                     maxSupply: maxSupply,
                     ath: ath,
                     athChangePercentage: athChangePercentage,
                     athDate: athDate,
                     atl: atl,
                     atlChangePercentage: atlChangePercentage,
                     atlDate: atlDate,
                     lastUpdated: lastUpdated,
                     sparklineIn7D: sparklineIn7D,
                     priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency,
                     currentHoldings: amount)
  }
  
  var currentHoldingsValue: Double {
    return (currentHoldings ?? 0) * currentPrice
  }
  
  var rank: Int {
    return Int(marketCapRank ?? 0)
  }
  
  var imageURL: URL {
    return URL(string: image) ?? URL(fileURLWithPath: "")
  }
  
  var coingeckoCoinDetail: URL {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else {
      return URL(fileURLWithPath: "")
    }
    return url
  }
  
  var sevenDatas: [Double] {
    return sparklineIn7D?.price ?? [0]
  }
  
  var startPrice: Double {
    return sparklineIn7D?.price?.first ?? 0
  }
  
  var endPrice: Double {
    return sparklineIn7D?.price?.last ?? 0
  }
  
  var priceChange: Double {
    return (sparklineIn7D?.price?.first ?? 0) - (sparklineIn7D?.price?.last ?? 0)
  }
}

struct SparklineIn7D: Codable, Equatable {
  let price: [Double]?
}

/*
 
 {
 "id": "bitcoin",
 "symbol": "btc",
 "name": "Bitcoin",
 "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
 "current_price": 16674.34,
 "market_cap": 320316868989,
 "market_cap_rank": 1,
 "fully_diluted_valuation": 350161135955,
 "total_volume": 22394149801,
 "high_24h": 16728.01,
 "low_24h": 16417.31,
 "price_change_24h": 121.06,
 "price_change_percentage_24h": 0.73131,
 "market_cap_change_24h": 2317370291,
 "market_cap_change_percentage_24h": 0.72873,
 "circulating_supply": 19210168,
 "total_supply": 21000000,
 "max_supply": 21000000,
 "ath": 69045,
 "ath_change_percentage": -75.83824,
 "ath_date": "2021-11-10T14:24:11.849Z",
 "atl": 67.81,
 "atl_change_percentage": 24502.09452,
 "atl_date": "2013-07-06T00:00:00.000Z",
 "last_updated": "2022-11-17T20:32:29.227Z",
 "sparkline_in_7d": {
 "price": [
 17257.577185576625,
 17329.897716447296,
 17407.17915171284,
 17749.445667985045,
 17892.36001260941,
 17822.058683159863,
 17594.923500278233,
 17560.268021058997,
 17323.249766274886,
 17134.63560474918,
 16965.3894194247,
 17046.07847279007,
 17277.28408186819,
 17286.983973948638,
 17460.35435368388,
 17432.225205364855,
 17389.639938322805,
 17269.50839533205,
 17335.195313152828,
 17337.779732070943,
 17381.631840478745,
 16852.621259096333,
 16875.984130266243,
 16824.74970999893,
 16829.440155103766,
 16850.96772567372,
 16800.926171751384,
 16635.021467229675,
 16812.103773563133,
 16938.103259894127,
 17080.215260565037,
 16900.750717833587,
 16853.43962686432,
 16932.397388331396,
 16881.18571800256,
 16832.655481419388,
 16670.45594413163,
 16772.331096831662,
 16797.037691112342,
 16844.694429173345,
 16866.545028629305,
 16847.583956633152,
 16841.663162434146,
 16840.10100735196,
 16832.28916215998,
 16874.99582417574,
 16928.67767896444,
 16886.875022798205,
 16907.05542882631,
 16865.692862414297,
 16890.700596783896,
 16802.16247512449,
 16823.301453566153,
 16831.06722498903,
 16797.98748257006,
 16875.102776772583,
 16864.438901654376,
 16879.2541947424,
 16903.961634132105,
 16878.630441008354,
 16853.313311560174,
 16692.55078362043,
 16733.457883101168,
 16716.961741576284,
 16529.746962045414,
 16579.136232701854,
 16675.52891257596,
 16628.713162252454,
 16674.603772874227,
 16630.567138493156,
 16571.909384480932,
 16610.87262894882,
 16541.814419337577,
 16506.907331643964,
 16550.206284051284,
 16515.9730914782,
 16409.05694280837,
 16441.150768995096,
 16344.342316001042,
 16273.562949306506,
 16054.95019045931,
 16069.653976665544,
 16175.751888956542,
 15988.743788879257,
 15931.386864071925,
 16580.766213073595,
 16831.582948198215,
 16752.54405937383,
 16797.861522997424,
 16825.319551245273,
 16777.026539866954,
 16824.3395847091,
 16988.28378838569,
 16593.01669736322,
 16614.779496097188,
 16507.117502596393,
 16594.097858649377,
 16641.894767312016,
 16482.68732742266,
 16302.382652976321,
 16415.6233047172,
 16436.629137493637,
 16645.828500283515,
 16581.79649537976,
 16749.586987173992,
 16779.86709960071,
 16874.217288011416,
 16787.279030627356,
 16776.02537960521,
 16674.65899343996,
 16732.915058330556,
 16817.05432071576,
 16927.92736736779,
 16795.995805460065,
 16831.315469627283,
 16806.84579045593,
 16895.02524166953,
 16958.615596238244,
 16883.101189397585,
 17044.682788091155,
 16999.185934513513,
 17012.123731873995,
 16707.257677987018,
 16820.58496349045,
 16820.062114949425,
 16912.747269948228,
 16898.266308137103,
 16890.52938386464,
 16816.567630161077,
 16864.861378096983,
 16971.477570910884,
 16962.710953225433,
 16906.534604557302,
 16941.666173327234,
 16852.479576357695,
 16878.44657453432,
 16774.882448604076,
 16741.035260606328,
 16731.065310389302,
 16713.46263663692,
 16647.439245679256,
 16588.221163820028,
 16475.449843515013,
 16528.640187034187,
 16534.106193668733,
 16578.250112917038,
 16563.51753152722,
 16565.85251404394,
 16599.5167018772,
 16562.50892038153,
 16571.94743116972,
 16689.39673273771,
 16710.785256065774,
 16712.606588416704,
 16663.306454521073,
 16569.611384863838,
 16522.14372563892,
 16579.687638660467,
 16583.954839506318,
 16606.589895674788,
 16605.145806109893,
 16537.21336091995,
 16549.389684701124,
 16588.771126081658,
 16571.051559256317,
 16473.582867086327,
 16523.81480321521,
 16576.32413292483,
 16653.340147597617
 ]
 },
 "price_change_percentage_24h_in_currency": 0.7313102845980812
 }
 
 */
