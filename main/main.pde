// GLOBALLY

// declare the variables corresponding to the column ids for x and y
final int X = 1;
final int Y = 2;

// Static class which content the min and max variables that you need in parseInfo
CityMinMax minMaxStat;

// the table in which the city data will be stored
City[] cities;

void setup() { 
  size(800,800);
  readData();
}

void readData() {
  String[] lines = loadStrings("./villes.tsv");
  parseInfo(lines[0]); // read the header line
  
  cities = new City[minMaxStat.TOTAL_COUNT];
  for (int i = 2 ; i < minMaxStat.TOTAL_COUNT+2; ++i) {
    String[] columns = split(lines[i], TAB);
    
    int postalcode = int (columns[0]);
    float x = float (columns[X]);
    float y = float (columns[Y]);
    String name = new String(columns[4]);
    float population = float (columns[5]);
    float surface = float (columns[6]);
    float altitude = float (columns[7]);
       
    cities[i-2] = new City(postalcode, name, x, y, population, surface, altitude, minMaxStat);
  }
  println("Density Max: " + minMaxStat.MAX_DENS);
}

void parseInfo(String line) { 
  // remove the # 
  String infoString = line.substring(2);
  
  String[] infoPieces = split(infoString, ',');
  minMaxStat.TOTAL_COUNT = int(infoPieces[0]);
  minMaxStat.MIN_X = float(infoPieces[1]);
  minMaxStat.MAX_X = float(infoPieces[2]);
  minMaxStat.MIN_Y = float(infoPieces[3]);
  minMaxStat.MAX_Y = float(infoPieces[4]);
  minMaxStat.MIN_POP = float(infoPieces[5]);
  minMaxStat.MAX_POP = float(infoPieces[6]);
  minMaxStat.MIN_SURF = float(infoPieces[7]);
  minMaxStat.MAX_SURF = float(infoPieces[8]);
  minMaxStat.MIN_ALT = float(infoPieces[9]);
  minMaxStat.MIN_ALT = float(infoPieces[10]);
}

void draw(){ 
  background(255);
  for (int i = 0 ; i < minMaxStat.TOTAL_COUNT ; i++) {
    cities[i].drawCity();
  }
}