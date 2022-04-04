// This class holds data for the country and homicide rate
// It may have been slightly unnecessary, but compartmentalizing things like this helped me understand the project better
class Country {
  String country;
  String region;
  FloatDict rates;
  float max;
  
  // Constructor takes a row, reads in the country and region
  // Rates is a dict so you can easily get each year
  Country(TableRow row) {
    country = row.getString("Country");
    region = row.getString("Region");
    rates = new FloatDict();
    // For year in available years, convert the index to a string, get the column at that string, add it to the dict
    for (int year = 2001; year <= 2009; year++) {
      String k = String.valueOf(year);
      float v = row.getFloat(k);
      rates.set(k, v);
    }
    // Find the max in the rates to scale the graph later
    max = max(rates.valueArray());
  }
}
