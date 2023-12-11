Config              = {}
Config.MarkerType   = 1 -- Marker'ın işareti. Markerları kapatmak için -1 yapabilirsiniz. Marker listesi için: https://docs.fivem.net/game-references/markers/
Config.DrawDistance = 100.0 --Markerların ne kadar uzaktan gözükeceğini belirler
Config.ZoneSize     = {x = 7.0, y = 7.0, z = 1.0} -- Marker büyüklüğü
Config.MarkerColor  = {r = 255, g = 0, b = 0} --Marker rengi

Config.RequiredCopsMelon  = 0 --Toplarken, keserken, satarken gereken polis sayısı
Config.RequiredCopsSarap  = 0 --Toplarken, işlerken, satarken gereken polis sayısı

Config.TimeToCherryJuice  = 3  * 1000 -- vişne suyu yapma süresi
Config.TimeToSellCherryJuice     = 3  * 1000 --vişne suyu satma süresi

Config.CherryJuicePrice = 35 -- Vişne Suyunun fiyatı

Config.Locale = 'en'

Config.Zones = {
	CherryProcessing =	{x = -84.00, y = 1880.13, z = 196.01}, -- VİŞNE SUYU YAPMA YERİ   vector3(-82.45, 1880.13, 197.42)
	CherryJuiceDealer =	{x = -3020.81, y = 368.24, z = 13.48}, -- VİŞNE SUYU SATMA YERİ   vector3(-3020.81, 368.24, 14.93)
}

Config.DisableBlip = false --Blipsleri kapatmak istiyorsanız true yapın. Açılmasını 
Config.Map = {

  {name="Vişne Tarlası",      color = 1, scale = 0.8, id = 1, x = 1954.64, y = 4793.01, z = 43.4}, -- Vişne toplama noktası 
  {name="Vişne İşleme",       color = 1, scale = 0.8, id = 1, x = -86.28, y = 1880.23, z = 197.31}, -- Vişne suyu noktası
  {name="Vişne Suyu Satış",   color = 1, scale = 0.8, id = 1, x = -3021.74, y = 368.73, z = 14.68}, -- Vişne suyu satma noktası
}
