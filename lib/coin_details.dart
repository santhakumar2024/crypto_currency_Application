class coindetail {
    coindetail(
      {  
         required this.id,
          required this.symbol,
        required  this.name,
         required this.image, 
         required this.currentprice,
         required this.high24h,
         required this.low24h,
         required this.pricechange24h,
         required this.pricechangepercentage24h
             }
             ); 

    coindetail.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        symbol = json['symbol'];
        name = json['name'];
        image = json['image'];
        currentprice = json['current_price'];
        high24h = json['high_24h'];
        low24h = json['low_24h'];
        pricechange24h = json['price_change_24h'];
        pricechangepercentage24h = json['price_change_percentage_24h'];
    }

    late double currentprice;
    late double high24h;
    late String id;
    late String image;
    late double low24h;
    late String name;
    late double pricechange24h;
    late double pricechangepercentage24h;
    late String symbol;

    // Map<String, dynamic> toJson() {
    //     final Map<String, dynamic> data = Map<String, dynamic>();
    //     data['id'] = id;
    //     data['symbol'] = symbol;
    //     data['name'] = name;
    //     data['image'] = image;
    //     data['current_price'] = currentprice;
    //     data['high_24h'] = high24h;
    //     data['low_24h'] = low24h;
    //     data['price_change_24h'] = pricechange24h;
    //     data['price_change_percentage_24h'] = pricechangepercentage24h;
    //     return data;
    // }
}