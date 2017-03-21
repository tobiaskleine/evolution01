class StateScorer {
  
  float score(ConstructionState constructionState) {
    float totalUnfixedPointHeight = 0.0;
    float totalConnectionLength = 0.0;
    for (ConnectionPoint p: constructionState.points) {
      if (p.fixedPoint == false) {
        totalUnfixedPointHeight += p.y;
      }
    }

    for (Connection c: constructionState.connections) {
      if (c.isBroken == false) {
        totalConnectionLength += c.standardLength;
      }
    }

    return totalUnfixedPointHeight;
  }
}

class StateMutator {
  
}


class Application {
   int frameRate = 120; 
   float speedUp = 3.0;
   float gravity = 999.0;
   int progressCount = 0;
     
   StateScorer stateScorer = new StateScorer();
   StateMutator stateMutator = new StateMutator();
   
   ArrayList<ConstructionState> constructions = new ArrayList<ConstructionState>();
   ConstructionState constructionState = new ConstructionState();
   ConstructionState constructionState2 = new ConstructionState();
  
  void setup() {
    stroke(255);     // Set line drawing color to white
    frameRate(frameRate);
    constructionState.generate();
    constructionState2.generate();
  }
  
  void draw() {
    float baselineY = height * 0.8;
    background(140);   // Clear the screen with a black background
    constructionState.progress(1.0 / frameRate * speedUp, gravity);
    constructionState.draw(0, baselineY, 0.5);
    constructionState2.progress(1.0 / frameRate * speedUp, gravity);
    constructionState2.draw(width*0.3, baselineY, 0.5);
      text(str(stateScorer.score(constructionState)), 30, baselineY + 50);
      text(str(stateScorer.score(constructionState2)), width*0.3 + 30, baselineY + 50);
    progressCount++;
  }
  
}