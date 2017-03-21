class Connection {
  ConnectionPoint p1;
  ConnectionPoint p2;
  
  float standardLength;
  float springConst;
  boolean isBroken = false;
  
  Connection(ConnectionPoint p1, ConnectionPoint p2) {
    this(p1, p2, p1.dist(p2) * 1.0);
  }

  Connection(ConnectionPoint p1, ConnectionPoint p2, float standardLength) {
    this.p1 = p1;
    this.p2 = p2;
    this.standardLength = standardLength; 
    springConst = 500.0;
  }

  void processBreaking() {
    float stretchFactor = (p1.dist(p2) / standardLength);
    if (stretchFactor > 1.2 || stretchFactor < 0.8) {
      isBroken = true;
      p1 = new ConnectionPoint(p1.x, p1.y);
      p2 = new ConnectionPoint(p2.x, p2.y);
    }
  }
  
  PVector calculateForceP1() {
    float stretchFactor = (p1.dist(p2) / standardLength);
    float forcePerLength = (1.0 - stretchFactor)*springConst;
    return p1.copy().sub(p2).mult(forcePerLength);
  }

  PVector calculateForceP2() {
    return calculateForceP1().mult(-1.0);
  }
}