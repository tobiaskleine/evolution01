class ConstructionState {
   ArrayList<ConnectionPoint> points = new ArrayList<ConnectionPoint>();
   ArrayList<Connection> connections = new ArrayList<Connection>();
   
   float hardBottom = -50.0;

  void generate() {
    ArrayList<ConnectionPoint> fixedPoints = new ArrayList<ConnectionPoint>();
    fixedPoints.add(new ConnectionPoint(140, 0, true));
    fixedPoints.add(new ConnectionPoint(240, 0, true));
    fixedPoints.add(new ConnectionPoint(300, 0, true));
    fixedPoints.add(new ConnectionPoint(360, 0, true));
    fixedPoints.add(new ConnectionPoint(440, 0, true));
    fixedPoints.add(new ConnectionPoint(190, 350));
    fixedPoints.add(new ConnectionPoint(280, 350));
    for (ConnectionPoint p: fixedPoints) {
      points.add(p);
    }
    
    for (int i = 0; i < 20; i++) {
      points.add(new ConnectionPoint(200.0 + randomGaussian()*100.0,150.0 + randomGaussian()*100.0));
    }
    
    for (int i = 0; i < 50; i++) {
      ConnectionPoint p1;
      ConnectionPoint p2;
      if (random(1.0) > 0.7) {
        p1 = points.get(floor(random(points.size())-0.001));
      } else {
        p1 = fixedPoints.get(floor(random(fixedPoints.size()-0.001)));
      }
      if (random(1.0) > 0.7 || p1.fixedPoint) {
        p2 = points.get(floor(random(points.size())-0.0001));
      } else {
        p2 = fixedPoints.get(floor(random(fixedPoints.size()-0.001)));
      }
      
      connections.add(new Connection(p1, p2));
    }
  }

  void progress(float dt, float gravity) {
    for (Connection c: connections) {
      c.processBreaking();
      if (!c.isBroken) {
        c.p1.applyForce(c.calculateForceP1(),dt);
        c.p2.applyForce(c.calculateForceP2(),dt);
      }
    }
    for (ConnectionPoint p: points) {
      if (Float.isNaN(p.y)) {  
        print("pre gravity");
      }
      p.applyGravity(gravity, dt);
      if (Float.isNaN(p.y)) {
        print("post gravity");
      }
      p.advance(dt);
      if (Float.isNaN(p.y)) {
        print("post advance");
      }
      if (p.y < hardBottom) {
        p.y = hardBottom;  
      }
    }
  }
  
  void draw(float offsetX, float offsetY, float scale) {
    for (Connection c: connections) {
      if (c.isBroken) {
        stroke(240, 100, 100);
      } else {
        stroke(180);
      }
      strokeWeight(3*scale);
        line(offsetX + c.p1.x*scale, offsetY - c.p1.y*scale, offsetX + c.p2.x*scale, offsetY - c.p2.y*scale);
    }
    for (ConnectionPoint p: points) {
      noStroke();
      if (p.fixedPoint) {
        fill(50,250,50);
      } else {
        fill(255);
      }
      ellipse(offsetX + p.x*scale, offsetY -  p.y*scale, 10.0*scale, 10.0*scale);
    }
  }

}