ArrayList<PVector> drawn = new ArrayList<PVector>();

float rotX, rotY;
float sphereR = 220;

float writeSpeed = 0.025;
float u = 0;
int segID = 0;
int nameStage = 0;

void setup(){
  size(1200, 800, P3D);
  smooth(8);
}

void draw(){
  background(18);
  lights();

  translate(width/2, height/2);
  rotateX(rotX);
  rotateY(rotY);

  drawSphereWire();
  writeNames();
  drawInk();
}

// =======================

void drawSphereWire(){
  noFill();
  stroke(130);
  sphereDetail(30);
  sphere(sphereR);
}

void drawInk(){
  noStroke();
  fill(210,0,255);

  for(PVector p : drawn){
    pushMatrix();
    translate(p.x,p.y,p.z);
    sphere(1);
    popMatrix();
  }
}

// =======================

PVector pointOnSphere(float x, float y, int zone){

  float thetaOffset = 0;
  if(zone == 0) thetaOffset = -PI/2;
  if(zone == 1) thetaOffset = 0;
  if(zone == 2) thetaOffset = PI/2;

  float theta = map(x,-200,200,-PI/3,PI/3) + thetaOffset;
  float phi   = map(y,-40,40,PI*0.45,PI*0.65);

  float sx = sphereR*sin(phi)*cos(theta);
  float sy = sphereR*sin(phi)*sin(theta);
  float sz = sphereR*cos(phi);

  return new PVector(sx,sy,sz);
}

// =======================

void writeNames(){

  String name="";
  float offset=0;
  int maxSeg=0;

  if(nameStage == 0){ name="DANTE"; offset=-90; maxSeg=16; }
  else if(nameStage == 1){ name="ANA"; offset=-20; maxSeg=9; }
  else if(nameStage == 2){ name="ADRIEL"; offset=60; maxSeg=18; }
  else return;

  PVector p = letterPath(name, segID, u, offset);

  if(p != null){
    PVector sp = pointOnSphere(p.x, p.z, nameStage);
    drawn.add(sp);
  }

  u += writeSpeed;

  if(u >= 1){
    u = 0;
    segID++;

    if(segID >= maxSeg){
      segID = 0;
      nameStage++;
    }
  }
}

// =======================

PVector seg(PVector a, PVector b, float t){
  return PVector.lerp(a,b,t);
}

// =======================

PVector letterPath(String name, int id, float t, float x0){

  float s = 18;
  float y = 0;
  float gap = 30;

  // -------- DANTE --------
  if(name.equals("DANTE")){
    switch(id){

      case 0: return seg(new PVector(x0,y,-s), new PVector(x0,y,s), t);
      case 1: return seg(new PVector(x0,y,s), new PVector(x0+20,y,s*0.7), t);
      case 2: return seg(new PVector(x0+20,y,s*0.7), new PVector(x0+20,y,-s*0.7), t);
      case 3: return seg(new PVector(x0+20,y,-s*0.7), new PVector(x0,y,-s), t);

      case 4: return seg(new PVector(x0+gap,y,-s), new PVector(x0+gap+12,y,s), t);
      case 5: return seg(new PVector(x0+gap+12,y,s), new PVector(x0+gap+24,y,-s), t);
      case 6: return seg(new PVector(x0+gap+6,y,0), new PVector(x0+gap+18,y,0), t);

      case 7: return seg(new PVector(x0+2*gap,y,-s), new PVector(x0+2*gap,y,s), t);
      case 8: return seg(new PVector(x0+2*gap,y,s), new PVector(x0+2*gap+20,y,-s), t);
      case 9: return seg(new PVector(x0+2*gap+20,y,-s), new PVector(x0+2*gap+20,y,s), t);

      case 10: return seg(new PVector(x0+3*gap,y,s), new PVector(x0+3*gap+20,y,s), t);
      case 11: return seg(new PVector(x0+3*gap+10,y,s), new PVector(x0+3*gap+10,y,-s), t);

      case 12: return seg(new PVector(x0+4*gap,y,s), new PVector(x0+4*gap,y,-s), t);
      case 13: return seg(new PVector(x0+4*gap,y,s), new PVector(x0+4*gap+20,y,s), t);
      case 14: return seg(new PVector(x0+4*gap,y,0), new PVector(x0+4*gap+18,y,0), t);
      case 15: return seg(new PVector(x0+4*gap,y,-s), new PVector(x0+4*gap+20,y,-s), t);
    }
  }

  // -------- ANA --------
  if(name.equals("ANA")){
    switch(id){
      case 0: return seg(new PVector(x0,y,-s), new PVector(x0+12,y,s), t);
      case 1: return seg(new PVector(x0+12,y,s), new PVector(x0+24,y,-s), t);
      case 2: return seg(new PVector(x0+6,y,0), new PVector(x0+18,y,0), t);

      case 3: return seg(new PVector(x0+gap,y,-s), new PVector(x0+gap,y,s), t);
      case 4: return seg(new PVector(x0+gap,y,s), new PVector(x0+gap+20,y,-s), t);
      case 5: return seg(new PVector(x0+gap+20,y,-s), new PVector(x0+gap+20,y,s), t);

      case 6: return seg(new PVector(x0+2*gap,y,-s), new PVector(x0+2*gap+12,y,s), t);
      case 7: return seg(new PVector(x0+2*gap+12,y,s), new PVector(x0+2*gap+24,y,-s), t);
      case 8: return seg(new PVector(x0+2*gap+6,y,0), new PVector(x0+2*gap+18,y,0), t);
    }
  }

  // -------- ADRIEL --------
  if(name.equals("ADRIEL")){
    switch(id){

      case 0: return seg(new PVector(x0,y,-s), new PVector(x0+12,y,s), t);
      case 1: return seg(new PVector(x0+12,y,s), new PVector(x0+24,y,-s), t);
      case 2: return seg(new PVector(x0+6,y,0), new PVector(x0+18,y,0), t);

      case 3: return seg(new PVector(x0+gap,y,-s), new PVector(x0+gap,y,s), t);
      case 4: return seg(new PVector(x0+gap,y,s), new PVector(x0+gap+25,y,s*0.7), t);
      case 5: return seg(new PVector(x0+gap+25,y,s*0.7), new PVector(x0+gap+25,y,-s*0.7), t);
      case 6: return seg(new PVector(x0+gap+25,y,-s*0.7), new PVector(x0+gap,y,-s), t);

      case 7: return seg(new PVector(x0+2*gap,y,-s), new PVector(x0+2*gap,y,s), t);
      case 8: return seg(new PVector(x0+2*gap,y,s), new PVector(x0+2*gap+18,y,s*0.6), t);
      case 9: return seg(new PVector(x0+2*gap+18,y,s*0.6), new PVector(x0+2*gap,y,0), t);
      case 10:return seg(new PVector(x0+2*gap,y,0), new PVector(x0+2*gap+20,y,-s), t);

      case 11:return seg(new PVector(x0+3*gap,y,-s), new PVector(x0+3*gap,y,s), t);

      case 12:return seg(new PVector(x0+4*gap,y,s), new PVector(x0+4*gap,y,-s), t);
      case 13:return seg(new PVector(x0+4*gap,y,s), new PVector(x0+4*gap+20,y,s), t);
      case 14:return seg(new PVector(x0+4*gap,y,0), new PVector(x0+4*gap+18,y,0), t);
      case 15:return seg(new PVector(x0+4*gap,y,-s), new PVector(x0+4*gap+20,y,-s), t);

      case 16:return seg(new PVector(x0+5*gap,y,s), new PVector(x0+5*gap,y,-s), t);
      case 17:return seg(new PVector(x0+5*gap,y,-s), new PVector(x0+5*gap+20,y,-s), t);
    }
  }

  return null;
}

// =======================

void mouseDragged(){
  rotY += (mouseX - pmouseX) * 0.01;
  rotX -= (mouseY - pmouseY) * 0.01;
}
