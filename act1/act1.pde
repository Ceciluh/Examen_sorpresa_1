PShape base, link1, link2, link3, link4, link5, link6;
float rotX, rotY;
float posX=1, posY=50, posZ=0;
float alpha, beta, gamma;
float F = 50, T = 70;

float tGlobal = 0;
float speed = 0.08;   
boolean finished = false;
ArrayList<PVector> trail = new ArrayList<PVector>();
float R = 85; 

void IK(){
  float X = posX; float Y = posY; float Z = posZ;
  float L = sqrt(Y*Y+X*X);
  float dia = sqrt(Z*Z+L*L);
  dia = constrain(dia, abs(F-T)+0.1, F+T-0.1); 
  alpha = PI/2-(atan2(L, Z)+acos((T*T-F*F-dia*dia)/(-2*F*dia)));
  beta  = -PI+acos((dia*dia-T*T-F*F)/(-2*F*T));
  gamma = atan2(Y, X);
}

PVector mapToSphere(float lon, float lat) {
  float longitude = radians(lon);
  float latitude = radians(lat);
  float x = R * cos(latitude) * cos(longitude);
  float y = R * cos(latitude) * sin(longitude);
  float z = R * sin(latitude);
  return new PVector(x, y, z);
}

void writeInSphere(){
  if(finished) return;
  tGlobal += speed;
  int segment = int(tGlobal);
  float t = tGlobal - segment;
  float s = 15; 
  PVector raw = new PVector(0,0);

  switch(segment){
    // ANA
    case 0: raw = new PVector(lerp(-30,-20,t), lerp(-s,s,t)); break;
    case 1: raw = new PVector(lerp(-20,-10,t), lerp(s,-s,t)); break;
    case 2: raw = new PVector(lerp(-25,-15,t), 0); break;
    case 3: raw = new PVector(0, lerp(-s,s,t)); break;
    case 4: raw = new PVector(lerp(0,15,t), lerp(s,-s,t)); break;
    case 5: raw = new PVector(15, lerp(-s,s,t)); break;
    case 6: raw = new PVector(lerp(25,35,t), lerp(-s,s,t)); break;
    case 7: raw = new PVector(lerp(35,45,t), lerp(s,-s,t)); break;
    case 8: raw = new PVector(lerp(30,40,t), 0); break;
    // DANTE
    case 9:  raw = new PVector(70, lerp(-s,s,t)); break;
    case 10: raw = new PVector(lerp(70,90,t), lerp(s,0,t)); break;
    case 11: raw = new PVector(lerp(90,70,t), lerp(0,-s,t)); break;
    case 12: raw = new PVector(lerp(100,110,t), lerp(-s,s,t)); break;
    case 13: raw = new PVector(lerp(110,120,t), lerp(s,-s,t)); break;
    case 14: raw = new PVector(lerp(105,115,t), 0); break;
    case 15: raw = new PVector(130, lerp(-s,s,t)); break;
    case 16: raw = new PVector(lerp(130,150,t), lerp(s,-s,t)); break;
    case 17: raw = new PVector(150, lerp(-s,s,t)); break;
    case 18: raw = new PVector(lerp(160,185,t), s); break;
    case 19: raw = new PVector(172, lerp(s,-s,t)); break;
    case 20: raw = new PVector(195, lerp(s,-s,t)); break;
    case 21: raw = new PVector(195, s); break;
    case 22: raw = new PVector(195, 0); break;
    case 23: raw = new PVector(195, -s); break;
    // ADRIEL
    case 24: raw = new PVector(lerp(220,230,t), lerp(-s,s,t)); break;
    case 25: raw = new PVector(lerp(230,240,t), lerp(s,-s,t)); break;
    case 26: raw = new PVector(lerp(225,235,t), 0); break;
    case 27: raw = new PVector(250, lerp(-s,s,t)); break;
    case 28: raw = new PVector(lerp(250,265,t), lerp(s,0,t)); break;
    case 29: raw = new PVector(lerp(265,250,t), lerp(0,-s,t)); break;
    case 30: raw = new PVector(275, lerp(-s,s,t)); break;
    case 31: raw = new PVector(lerp(275,285,t), lerp(s,0,t)); break;
    case 32: raw = new PVector(lerp(285,295,t), lerp(0,-s,t)); break;
    case 33: raw = new PVector(305, lerp(-s,s,t)); break;
    case 34: raw = new PVector(315, lerp(-s,s,t)); break;
    case 35: raw = new PVector(330, lerp(-s,s,t)); break;
    default: finished = true; return;
  }

  PVector p = mapToSphere(raw.x, raw.y);
  posX = p.x; posY = p.y; posZ = p.z;
  IK();
}

void setup(){
  size(1200,800,OPENGL);
  // CARGA DE ARCHIVOS SEGUN TU IMAGEN
  base  = loadShape("link_base.obj");
  link1 = loadShape("link1.obj");
  link2 = loadShape("link2.obj");
  link3 = loadShape("link3.obj");
  link4 = loadShape("link4.obj");
  link5 = loadShape("link5.obj");
  link6 = loadShape("link6.obj");

  base.disableStyle();
  link1.disableStyle(); link2.disableStyle(); link3.disableStyle();
  link4.disableStyle(); link5.disableStyle(); link6.disableStyle();
}

void draw(){
  writeInSphere();
  background(25);
  lights();
  if(!finished) trail.add(new PVector(posX,posY,posZ));
  
  translate(width/2, height/2);
  rotateX(rotX); rotateY(-rotY);
  scale(3.5);

  // Trazo
  for(PVector p : trail){
    pushMatrix();
    translate(p.x, p.y, p.z);
    fill(#D003FF, 180); noStroke();
    sphere(1);
    popMatrix();
  }

  // ROBOT XARM6 JERARQUIA
  fill(#FFE308); noStroke();
  
  shape(base);
  rotateY(gamma); 
  shape(link1);
  
  translate(0, 25, 0); // Ajuste de altura link1
  rotateY(PI);
  rotateX(alpha); 
  shape(link2);
  
  translate(0, 0, 50); // Largo link2
  rotateY(PI);
  rotateX(beta); 
  shape(link3);
  
  // Eslabones finales (4, 5, 6) alineados al brazo
  shape(link4);
  translate(0, 0, -20);
  shape(link5);
  translate(0, 0, -10);
  shape(link6);
}

void mouseDragged(){
  rotY -= (mouseX-pmouseX)*0.01;
  rotX -= (mouseY-pmouseY)*0.01;
}

void keyPressed(){
  if(key=='r'){ trail.clear(); tGlobal = 0; finished = false; }
}
