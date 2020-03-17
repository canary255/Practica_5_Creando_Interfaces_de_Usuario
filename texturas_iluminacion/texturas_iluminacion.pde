boolean positiveAngle=false;
boolean negativeAngle=false;
boolean positiveHorizontalAngle=false;
boolean negativeHorizontalAngle=false;

boolean coordinate=false;
boolean coordinateAtras=false;

float x=455.48,y=288.240,z=378.23;
int colorCielo;
int linterna=0;
boolean modoDia=true;
int fadeAway=0;
float posSol=0.1;
float posLuna=0.1;
float x1=0,y1=0,x2=0,y2=0;
PShape cabeza,cuerpo,punio,pelota;

int mensaje=1;
int tonoLuz=0;

float centerX=438.25,centerY=258.66,centerZ=-580.27;



PImage imgCesped,saitamaFace,saitama_Body_Front,saitama_Sides;

PImage[] texturas;

void setup(){
  size(900,600,P3D);
  imgCesped=loadImage("tierra.jpg");
  saitamaFace=loadImage("saitama_face.jpg");
  saitama_Body_Front=loadImage("saitama_cuerpo_frente.jpg");
  saitama_Sides=loadImage("saitama_lados.jpg");
  texturas= new PImage[5];
  texturas[0] = loadImage("pelota.jpg");
  texturas[1] = loadImage("pelota_2.jpg");
  texturas[2] = loadImage("pelota_3.jpg");
  texturas[3] = loadImage("pelota_4.jpg");
  texturas[4] = loadImage("pelota_5.jpg");
  textureMode(NORMAL);
}

void draw(){
  background(0);
  noStroke();
  
  if(mensaje==1){
    camera();
    muestraTexto();
  } else {
  
    creaCielo();
    creaSol(0.01);
    creaLuna(0.01);
    camera(x,y,z,centerX,centerY,centerZ,0,1,0);
    modoLinterna();
    creaSaitama();
    
    pushMatrix();
    if(y1 < 366){
      colocarLuzSolar();
      directionalLight(tonoLuz,tonoLuz,tonoLuz,-cos(posSol),-sin(posSol),0);
    } else if (y2 < 366){
      colocarLuzLunar();
      directionalLight(tonoLuz,tonoLuz,tonoLuz,cos(posLuna),sin(posLuna),0);
    }
    translate(380,250,65);
    pelota=createShape(SPHERE, 25);
    pelota.setTexture(texturas[0]);
    pelota.rotateY(2.8);
    pelota.rotateX(-1);
    shape(pelota);
    popMatrix();
    
    pushMatrix();
    if(y1 < 366){
      colocarLuzSolar();
      directionalLight(tonoLuz,tonoLuz,tonoLuz,-cos(posSol),-sin(posSol),0);
    } else if (y2 < 366){
      colocarLuzLunar();
      directionalLight(tonoLuz,tonoLuz,tonoLuz,cos(posLuna),sin(posLuna),0);
    }
    translate(520,250,65);
    pelota=createShape(SPHERE, 25);
    pelota.setTexture(texturas[1]);
    pelota.rotateY(1.2);
    pelota.rotateX(-1);
    shape(pelota);
    popMatrix();
    
    /*pushMatrix();
    translate(450,250,-40);
    lights();
    pelota=createShape(SPHERE, 100);
    pelota.setTexture(texturas[(int)random(5)]);
    noLights();
    pelota.rotateY(1.8);
    shape(pelota);
    popMatrix();*/
    
    
    pushMatrix();
    translate(450,440,110);
    noFill();
    scale(90);
    cuboConTextura();
    popMatrix();
    teclaPulsada();
    
    if(y1 > 366){
      modoDia=false;
    } else if(y1 <366){
      modoDia=true;
    }
    
    
    // Day: If modoDia = even number, then... 
    if (modoDia == true) {
      fadeAway += 5;
    }
    // Night: If modoDia = odd number, then...
    else {
      fadeAway -= 5;
    }
  
    // If the "fadeAway" opacity is less than 1, stay at 1!
    if (fadeAway < 1) {
      fadeAway = 1;
    }
    // If the "fadeAway" opacity is greater than 255, then stay at 255! 
    if (fadeAway > 255) {
      fadeAway = 255;
    }
  }
  
}



void creaSol(float vel){
  pushMatrix();
  fill(#ff8000);
  x1 = 450 + 350*cos(posSol);
  y1 = 440 + 350*sin(posSol);
  translate(x1,y1,110-300);
  lights();
  sphere(50);
  popMatrix();
  posSol-=vel;
}

void creaLuna(float vel){
  pushMatrix();
  fill(255);
  x2 = 450 - 350*cos(posLuna);
  y2 = 440 - 350*sin(posLuna);
  translate(x2,y2,110-300);
  lights();
  sphere(25);
  popMatrix();
  posLuna-=vel;
}

void creaCielo(){
  pushMatrix();
  fill(0x25,0x28,0x50);
  translate(450,440-75,110);
  sphere(600);
  popMatrix();
  
  pushMatrix();
  fill(0x02,0x5B,0xA7,fadeAway);
  translate(450,440-75,110);
  sphere(600);
  popMatrix();
}

void mouseClicked(){
  linterna++;
  if(linterna > 3) linterna=0;
}

void keyPressed(){
  
  if(mensaje==0){
    if(keyCode==UP){
      positiveAngle=true;
    } else if(keyCode==DOWN){
      negativeAngle=true;
    }
    
    if(keyCode==RIGHT){
      positiveHorizontalAngle=true;
    } else if(keyCode==LEFT){
      negativeHorizontalAngle=true;
    }
    
    
    if(key=='w' || key=='W'){
      coordinate=true;
    } else if (key=='s' || key=='S'){
      coordinateAtras=true;
    }
    
    if(key==' '){
      x=455.48;
      y=288.240;
      z=378.23;
      centerX=438.25;
      centerY=258.66;
      centerZ=-580.27;
    }
    
    if(key== 'h' || key== 'H'){
      mensaje=1;
    }
  } else if(mensaje==1){
    if(key== 'h' || key== 'H'){
      mensaje=0;
    }
  }

}

void keyReleased(){
  if(keyCode==UP){
    positiveAngle=false;
  } else if(keyCode==DOWN){
    negativeAngle=false;
  }
  
  if(keyCode==RIGHT){
    positiveHorizontalAngle=false;
  } else if(keyCode==LEFT){
    negativeHorizontalAngle=false;
  }
  
    if(key=='w' || key=='W'){
    coordinate=false;
  } else if (key=='s' || key=='S'){
    coordinateAtras=false;
  }

}

void teclaPulsada(){
  if(positiveAngle){
      centerY-=10;
  } else if(negativeAngle){
      centerY+=10;
  }
  
  if(positiveHorizontalAngle){
      PVector point = rotacion(new PVector(centerX - x,centerY - y,centerZ -z),1);
      centerX = point.x + x; centerY = point.y +y; centerZ = point.z + z;
  } else if(negativeHorizontalAngle){
      PVector point = rotacion(new PVector(centerX - x,centerY - y,centerZ -z),-1);
      centerX = point.x + x; centerY = point.y +y; centerZ = point.z + z;
  }
  
  if(coordinate){
      if(x+(centerX-x)/100<710 && x+(centerX-x)/100>20){
        x= x+(centerX-x)/100;
        centerX = centerX+(centerX-x)/100;
      }
      if(y+(centerY-y)/100<=290 && y+(centerY-y)/100>=-100){
      y= y+(centerY-y)/100;
      centerY = centerY+(centerY-y)/100;
      }
      if(z+(centerZ-z)/100<389 && z+(centerZ-z)/100>-177){
          z= z+(centerZ-z)/100;
          centerZ = centerZ+(centerZ-z)/100; 
      }
  } else if(coordinateAtras){
      if(x-(centerX-x)/100<710 && x-(centerX-x)/100>20){
         x= x-(centerX-x)/100;
         centerX = centerX-(centerX-x)/100; 
      }
      if(y-(centerY-y)/100<=290 && y-(centerY-y)/100>=-100){
        y= y-(centerY-y)/100;
        centerY = centerY-(centerY-y)/100;
      }
      if(z-(centerZ-z)/100<389 && z-(centerZ-z)/100>-177){
          z= z-(centerZ-z)/100;
          centerZ = centerZ-(centerZ-z)/100; 
      }
  }
 
  
  
}



PVector rotacion(PVector point,int direccion) {
  float cos = (float) Math.cos(radians(direccion*2));
  float sin = (float) Math.sin(radians(direccion*2));
  float x = point.x * cos  - point.z* sin;
  float z = point.x * sin + point.z * cos;
  
  return new PVector(x, point.y, z);
}


void muestraTexto(){
  textSize(36);
  text("Texturas e iluminación",(width/2) - 200,72);
  textSize(15);
   text("W y S - Mueve la Cámara",16,(height/2)-100);
   text("Flechas - Rota la cámara",16,(height/2)-80);
   text("Espacio - Resetea coordenadas", 16,(height/2)-60);
   text("Click izquierdo (solo modo noche) - coloca una luz en las figuras con una intensidad (tiene 3 intensidades diferentes)", 16,(height/2)-40);
   text("H - Muestra/Oculta la ayuda", 16,(height/2)-20);
}


void cuboConTextura(){
  
  
  beginShape(QUADS);
  texture(imgCesped);

  // -Y "middle" face
  lights();
  vertex(-6, -1, -6, 0, 0);
  vertex( 6, -1, -6, 1, 0);
  vertex( 6, -1,  6, 1, 1);
  vertex(-6, -1,  6, 0, 1);
  
  endShape();
}



//cabeza: 325,284,78
void creaSaitama(){
  
  //cabeza
  pushMatrix();
  if(y1 < 366){
    colocarLuzSolar();
    directionalLight(tonoLuz,tonoLuz,tonoLuz,-cos(posSol),-sin(posSol),0);
  } else if (y2 < 366){
    colocarLuzLunar();
    directionalLight(tonoLuz,tonoLuz,tonoLuz,cos(posLuna),sin(posLuna),0);
  }
  translate(450,253,90);
  cabeza = createShape(SPHERE, 25); 
  cabeza.setTexture(saitamaFace);
  cabeza.rotateY(1.8);
  shape(cabeza);
  popMatrix();
  
  //cuerpo
  
  creaCuerpo();
  
  //BRAZOS
  
  pushMatrix();
  translate(424,295,90);
  creaBrazos();
  popMatrix();
  
  pushMatrix();
  translate(476,295,90);
  creaBrazos();
  popMatrix();
  
  //PUÑOS
  
  pushMatrix();
  translate(424,320,90);
  fill(255,0,0);
  sphere(8);
  popMatrix();
  fill(255);
  
  pushMatrix();
  translate(476,320,90);
  fill(255,0,0);
  sphere(8);
  popMatrix();
  fill(255);
  
  //PIERNAS
  
  pushMatrix();
  translate(440,340,90);
  creaPiernas();
  popMatrix();
  
  pushMatrix();
  translate(460,340,90);
  creaPiernas();
  popMatrix();
}

void colocarLuzSolar(){
    if(x1 > 580 && x1 < 800 && y1 <370){
      tonoLuz+=3;
    if(tonoLuz>128){
      tonoLuz=128;
    }
  } else if(x1 >290 && x1 <=580 && y1 <366){
       tonoLuz+=3;
      if(tonoLuz>255){
        tonoLuz=255;
      }
  } else if(x1 >100 && x1 <=290 && y1 < 366){
      tonoLuz-=3;
      if(tonoLuz<0){
        tonoLuz=0;
      }
  } else if(y1>=366){
      tonoLuz=0;
  }
}

void colocarLuzLunar(){
    if(x2 < 800 && y2 <366){
      tonoLuz+=3;
      if(tonoLuz>96){
        tonoLuz=96;
      }
    } else if(y2 >=366){
      tonoLuz=0;
    }
}


void modoLinterna(){
    if(y2 < 366){
      if(linterna==1){
        pointLight(20, 20, 20, x, y, z);
      } else if(linterna==2){
        pointLight(80, 80, 80, x, y, z);
      } else if(linterna==3){
        pointLight(160, 160, 160, x, y, z);
      }
    } else {
      linterna=0;
    }
}


void creaCuerpo(){

pushMatrix();
  translate(450,300,90);
  //cuerpo = createShape(BOX, 25); 
  //cuerpo.setTexture(saitamaFace);
  beginShape(QUADS);
  int Vx = 16;
  int Vy = 22;
  int Vz = 16;
  // +Z "front" face
  texture(saitama_Body_Front);
  vertex(-Vx, -Vy, Vz, 0, 0);
  vertex(Vx, -Vy, Vz, 1, 0);
  vertex(Vx, Vy, Vz, 1, 1);
  vertex(-Vx, Vy, Vz, 0, 1);
  endShape();
  
  beginShape(QUADS);
  texture(saitama_Sides);
  // -Z "back" face
  vertex(Vx, -Vy, -Vz, 0, 0);
  vertex(-Vx, -Vy, -Vz, 16, 0);
  vertex(-Vx, Vy, -Vz, 16, 16);
  vertex(Vx, Vy, -Vz, 0, 16);

  // +Y "bottom" face
  vertex(-Vx, Vy, Vz, 0, 0);
  vertex(Vx, Vy, Vz, 16, 0);
  vertex(Vx, Vy, -Vz, 16, 16);
  vertex(-Vx, Vy, -Vz, 0, 16);

  // -Y "top" face
  vertex(-Vx, -Vy, -Vz, 0, 0);
  vertex(Vx, -Vy, -Vz, 16, 0);
  vertex(Vx, -Vy, Vz, 16, 16);
  vertex(-Vx, -Vy, Vz, 0, 16);

  // +X "right" face
  vertex(Vx, -Vy, Vz, 0, 0);
  vertex(Vx, -Vy, -Vz, 16, 0);
  vertex(Vx, Vy, -Vz, 16, 16);
  vertex(Vx, Vy, Vz, 0, 16);

  // -X "left" face
  vertex(-Vx, -Vy, -Vz, 0, 0);
  vertex(-Vx, -Vy, Vz, 16, 0);
  vertex(-Vx, Vy, Vz, 16, 16);
  vertex(-Vx, Vy, -Vz, 0, 16);

  endShape();
  
  popMatrix();
}

void creaBrazos(){
  beginShape(QUADS);
  int Vx = 8;
  int Vy = 16;
  int Vz = 8;
  // +Z "front" face
  texture(saitama_Sides);
  vertex(-Vx, -Vy, Vz, 0, 0);
  vertex(Vx, -Vy, Vz, 1, 0);
  vertex(Vx, Vy, Vz, 1, 1);
  vertex(-Vx, Vy, Vz, 0, 1);
  
  // -Z "back" face
  vertex(Vx, -Vy, -Vz, 0, 0);
  vertex(-Vx, -Vy, -Vz, 16, 0);
  vertex(-Vx, Vy, -Vz, 16, 16);
  vertex(Vx, Vy, -Vz, 0, 16);

  // +Y "bottom" face
  vertex(-Vx, Vy, Vz, 0, 0);
  vertex(Vx, Vy, Vz, 16, 0);
  vertex(Vx, Vy, -Vz, 16, 16);
  vertex(-Vx, Vy, -Vz, 0, 16);

  // -Y "top" face
  vertex(-Vx, -Vy, -Vz, 0, 0);
  vertex(Vx, -Vy, -Vz, 16, 0);
  vertex(Vx, -Vy, Vz, 16, 16);
  vertex(-Vx, -Vy, Vz, 0, 16);

  // +X "right" face
  vertex(Vx, -Vy, Vz, 0, 0);
  vertex(Vx, -Vy, -Vz, 16, 0);
  vertex(Vx, Vy, -Vz, 16, 16);
  vertex(Vx, Vy, Vz, 0, 16);

  // -X "left" face
  vertex(-Vx, -Vy, -Vz, 0, 0);
  vertex(-Vx, -Vy, Vz, 16, 0);
  vertex(-Vx, Vy, Vz, 16, 16);
  vertex(-Vx, Vy, -Vz, 0, 16);

  endShape();
  
}


void creaPiernas(){
beginShape(QUADS);
  int Vx = 6;
  int Vy = 14;
  int Vz = 6;
  // +Z "front" face
  fill(255,0,0);
  vertex(-Vx, -Vy, Vz, 0, 0);
  vertex(Vx, -Vy, Vz, 1, 0);
  vertex(Vx, Vy, Vz, 1, 1);
  vertex(-Vx, Vy, Vz, 0, 1);
  
  // -Z "back" face
  vertex(Vx, -Vy, -Vz, 0, 0);
  vertex(-Vx, -Vy, -Vz, 16, 0);
  vertex(-Vx, Vy, -Vz, 16, 16);
  vertex(Vx, Vy, -Vz, 0, 16);

  // +Y "bottom" face
  vertex(-Vx, Vy, Vz, 0, 0);
  vertex(Vx, Vy, Vz, 16, 0);
  vertex(Vx, Vy, -Vz, 16, 16);
  vertex(-Vx, Vy, -Vz, 0, 16);

  // -Y "top" face
  vertex(-Vx, -Vy, -Vz, 0, 0);
  vertex(Vx, -Vy, -Vz, 16, 0);
  vertex(Vx, -Vy, Vz, 16, 16);
  vertex(-Vx, -Vy, Vz, 0, 16);

  // +X "right" face
  vertex(Vx, -Vy, Vz, 0, 0);
  vertex(Vx, -Vy, -Vz, 16, 0);
  vertex(Vx, Vy, -Vz, 16, 16);
  vertex(Vx, Vy, Vz, 0, 16);

  // -X "left" face
  vertex(-Vx, -Vy, -Vz, 0, 0);
  vertex(-Vx, -Vy, Vz, 16, 0);
  vertex(-Vx, Vy, Vz, 16, 16);
  vertex(-Vx, Vy, -Vz, 0, 16);

  endShape();
  
  fill(255);
}
