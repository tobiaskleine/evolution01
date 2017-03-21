
class ConnectionPoint extends PVector {
  PVector velocity = new PVector(0.0,0.0);
  float mass = 1.0;
  float damping = 5.0;
  boolean fixedPoint = false;
  
  
  ConnectionPoint(float x, float y) {
    this(x, y, false);
  }
  
  ConnectionPoint(float x, float y, boolean fixed) {
    super(x,y);
    this.fixedPoint = fixed;
  }
  
  void applyForce(PVector force, float dt) {
    print(force);
    velocity.add(force.copy().mult(1.0 / mass * dt));
  }
  
  void applyGravity(float g, float dt) {
    applyForce(new PVector(0, -1.0 * g * mass), dt);
  }
  
  void advance(float dt) {
    velocity.mult((1.0-dt*damping));
    if (fixedPoint) {
      return;
    }
    this.add(velocity.copy().mult(dt));
  }
  
}