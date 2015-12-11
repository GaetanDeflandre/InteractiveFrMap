public class City {
  
  // ATTRIBUTS
  private int postalcode;
  private String name;
  private float x;
  private float y;
  private float population;
  private float surface;
  private float altitude;
  private float density;
  
  private float radius;

  
  /**
   * Classe static, contenant les informations sur 
   * les minima et maxima des villes instanciées
   */
  private CityMinMax minMaxStat;
  

  // CONSTANTES
  // ==========
  public final static float MIN_DIAMETER = 2.0f;
  public final static float MAX_DIAMETER = 250.0f;
  public final static float MIN_LUM = 25.0f;
  public final static float MAX_LUM = 175.0f;
  
  
  
  // CONSTRUCTEUR
  // ============
  /**
   * Allocation d'un objet ville.
   */
  public City (int postalcode, String name, float x, float y, float population, float surface, float altitude, CityMinMax minMaxStat){
    this.postalcode = postalcode;
    this.name = name;
    this.x = x;
    this.y = y;
    this.population = population;
    this.surface = surface;
    this.altitude = altitude;
    
    this.density = computeDensity();
    
    if (name.equals("Paris")){
      println("Density Paris: " + this.density); 
    }
    
    this.minMaxStat = minMaxStat;
    
    if (minMaxStat.MIN_DENS == -1){
      minMaxStat.MIN_DENS = this.getDensity();
    } else if (minMaxStat.MIN_DENS > this.getDensity()){
      minMaxStat.MIN_DENS = this.getDensity();
    }
    
    if (minMaxStat.MAX_DENS == -1){
      minMaxStat.MAX_DENS = this.getDensity();
    } else if(minMaxStat.MAX_DENS < this.getDensity()) {
      minMaxStat.MAX_DENS = this.getDensity();
    }
  }
  
  
  
  // GETTER
  // ======
  public float getX(){
    return this.x; 
  }
  
  public float getY(){
    return this.y;
  }
  
  public int getPostalcode(){
    return this.postalcode;
  }
  
  public String getName(){
    return this.name; 
  }
  
  public float getPopulation(){
    return this.population;
  }
  
  public float getSurface(){
    return this.surface; 
  }
  
  public float getAltitude(){
    return this.altitude;
  }
  
  public float getDensity(){
    return this.density;
  }
  
  public float computeDensity(){
    if(this.getSurface() <= 0.0){
      return 0.0;
    }
    return this.getPopulation() / this.getSurface();
  }
  
  public float getRadius(){
    return radius;
  }
  
  
  
  // METHODES
  // ========
  
  private float mapX(float x) {
    return map(x, minMaxStat.MIN_X, minMaxStat.MAX_X, 0, 800);
  }
  
  private float mapY(float y) {
    return map(y, minMaxStat.MAX_Y, minMaxStat.MIN_Y, 0, 800);
  }
  
  /**
   * @param valInI1 Valeur du nombre à interpoler. Est dans l'intervalle 1 (I1) 
   * @param minI1 Valeur minimun de l'intervalle 1 (I1)
   * @param maxI1 Valeur maximum de l'intervalle 1 (I1)
   * @param minI2 Valeur minimun de l'intervalle 2 (I2)
   * @param maxI2 Valeur maximum de l'intervalle 2 (I2)
   * @return une valeur entre minI2 et maxI2, correspondant à la valeur valInI1 interpolé.
   */
  private float interpolateFromI1ToI2(float valInI1, float minI1, float maxI1, float minI2, float maxI2){
    float lenI1 = maxI1 - minI1;
    float lenI2 = maxI2 - minI2;
    
    return minI2 + ( lenI2*(valInI1-minI1) / lenI1 );
  }
  
  

  // FONCTION DRAW
  // =============
  
  /**
   * Nous dessinons les villes en fonction de leur nombre d'habitants 
   * et leurs densitées
   */
  public void drawCity(boolean isPicked){
    
    if(getPopulation() == 0.0 || getDensity() == 0.0){
      // check limit cases
      return;
    }
    
    if(int(getPopulation()) < minMaxStat.MIN_POP_TO_DISPLAY){
      // not display low population city 
      return;
    }
    
    if(int(getPopulation()) > minMaxStat.MAX_POP_TO_DISPLAY){
      // not display hight population city 
      return;
    }
    

    int posX = int(mapX(getX()));
    int posY = int(mapY(getY()));

    /*
    On recherche un diamètre correspondant à la population:
     - on divise alors une premier fois par PI, 
       pour que les aires des villes soit représentatives 
       de la population (et non le diamétre).
     - on interpole pour convertir un nombre d'habitant en diametre.
    */
    float popDiameter = interpolateFromI1ToI2(getPopulation(), minMaxStat.MIN_POP, minMaxStat.MAX_POP, MIN_DIAMETER, MAX_DIAMETER);
    float lumValue = interpolateFromI1ToI2(getDensity(), minMaxStat.MIN_DENS, minMaxStat.MAX_DENS, MIN_LUM, MAX_LUM);
    
    this.radius = popDiameter / 2.0;
    
    int satur;
    int bright;
    
    if (lumValue <= 100.0f){
      satur = int (lumValue);
      bright = 100;
    } else {
      satur = 100;
      bright = int (lumValue) - 100;
    }

    colorMode(HSB, 360, 100, 100);
    color densColor = color(200, satur, bright);
    
    colorMode(RGB, 255, 255, 255);
    if (isPicked){
      stroke(255,0,0);
    } else {
      stroke(0,0,0);
    }
    
    fill(densColor);
    ellipse(posX, posY, int(popDiameter), int(popDiameter));
    
  }
  
  public boolean contains(int px, int py){
    return dist(mapX(getX()), mapY(getY()), px, py) <= int(this.radius) + 1;
  }
}