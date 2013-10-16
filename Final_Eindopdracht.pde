  int stap = 20; // aantal stappen in pixels
  color l1 = #16437f; // kleur lijn 1
  color l2 = #cc0000; // kleur lijn 2
  color bBorder = #2c86ff; // kleur border bolletje
  
  int[] maxtempList = new int[36]; // lijst met de maximum temperaturen
  int[] mintempList = new int[36]; // lijst met de minimum temperaturen
  
  int labelValMaxtemp = 0; // labelwaarde maximum temperatuur 
  int labelValMintemp = 0; // labelwaarde minimum temperatuur
  
  int yHoogte = 500; // hoogte van de y waarde in pixels

void setup() { 
  // achtergrondafbeelding
  PImage img;
  img = loadImage("img/bg.png");
    
  size(800,600);
  background(img);
  maakAchtergrond();
  maakGrafiek();
}

void draw() {
  // achtergrondafbeelding
  PImage img;
  img = loadImage("img/bg.png");
  
  //font
  PFont font1;
  PFont font2;
  font1 = loadFont("CenturyGothic.vlw");
  font2 = loadFont("Casper.vlw");
  textFont(font1, 12);
  
  // checkt of de muis in het grafiekgebied is
  if (mouseX < 720 & mouseX > 100 & mouseY < 500 & mouseY > 100){
    
    // vult de maximum en minimum temperatuur voor de labels in de cirkels
    int labelValMax = maxtempList[round(mouseX/stap)];
    int labelValMin = mintempList[round(mouseX/stap)];
    
    // checkt of de temp variabele niet gelijk is aan de waarde van de label variabele
    if(labelValMax != labelValMaxtemp && labelValMin != labelValMintemp){
      background(img);
      maakAchtergrond();
      maakGrafiek();
      fill(0);
      
      // checkt of de huidige muis x positie kleiner is dan de vorige muis x positie
      if(mouseX < pmouseX){
         strokeWeight(3);
         fill(255);
         // tekent een ellipse op de muispositie/punt in de grafiek met een label met de waarde
         ellipse(mouseX-stap, yHoogte-labelValMax, 40, 40);
         Label label = new Label("" + float(labelValMax)/10, mouseX-stap-12, 516-labelValMax);
         strokeWeight(3);
         fill(255);
         ellipse(mouseX-stap, yHoogte-labelValMin, 40, 40);
         Label label2 = new Label("" + float(labelValMin)/10, mouseX-stap-12, 516-labelValMin);
      }
      else{
        strokeWeight(3);
         fill(255);
         ellipse(mouseX, yHoogte-labelValMax, 40, 40);
         Label label = new Label("" + float(labelValMax)/10, mouseX-12, 516-labelValMax);
         strokeWeight(3);
         fill(255);
         ellipse(mouseX, yHoogte-labelValMin, 40, 40);
         Label label2 = new Label("" + float(labelValMin)/10, mouseX-12, 516-labelValMin);
      }
    }
    
    labelValMaxtemp = labelValMax;
    labelValMintemp = labelValMin;
  }
}

// deze methode tekent de grafiek op het scherm aan de hand van data.
void maakGrafiek(){
  String lines[] = loadStrings("KNMI_20130831.txt"); // laadt tekstbestand met data
  int schakel = 0;
  
  int mintemp = 0;
  int mintemp1 = 0;
  int mintemp2 = 0;
  int x1Mintemp = 100;
  int x2Mintemp = 100;
  
  int maxtemp = 0;
  int maxtemp1 = 0;
  int maxtemp2 = 0;
  int x1Maxtemp = 100;
  int x2Maxtemp = 100;
  
  for (int i = 13; i<lines.length; i++) {
    String[] list = split(lines[i], ';');
    if(schakel == 0){
      mintemp1 = yHoogte-int(list[2]);
      
      maxtemp1 = yHoogte-int(list[3]);
      maxtempList[i-8] = int(list[3]);
      mintempList[i-8] = int(list[2]);
    }
    if(schakel == 1){
      mintemp2 = yHoogte-int(list[2]); 
      strokeWeight(3);
      stroke(l1);
      line(x1Mintemp, mintemp1, x2Mintemp+=stap, mintemp2);
      mintempList[i-8] = int(list[2]);
      
      strokeWeight(3);
      stroke(l2);
      maxtemp2 = yHoogte-int(list[3]); 
      line(x1Maxtemp, maxtemp1, x2Maxtemp+=stap, maxtemp2);
      maxtempList[i-8] = int(list[3]);
      
    }
    if (schakel > 1) {
     mintemp1 = mintemp2;
     mintemp2 = yHoogte-int(list[2]); 
     x1Mintemp = x2Mintemp;
     x2Mintemp += stap;
     strokeWeight(3);
     stroke(l1);
     line(x1Mintemp, mintemp1, x2Mintemp, mintemp2);
     mintempList[i-8] = int(list[2]);
     maxtemp1 = maxtemp2;
     maxtemp2 = yHoogte-int(list[3]); 
     x1Maxtemp = x2Maxtemp;
     x2Maxtemp += stap;
     strokeWeight(3);
     stroke(l2);
     line(x1Maxtemp, maxtemp1, x2Maxtemp, maxtemp2);
     maxtempList[i-8] = int(list[3]);
     
    }
    stroke(bBorder);
    schakel += 1;
  }  
  
}

// deze methode tekent het grid op de achtergrond
void maakAchtergrond(){
  //font
  PFont font1;
  PFont font2;
  PFont font3;
  font1 = loadFont("CenturyGothic.vlw");
  font2 = loadFont("Casper.vlw");
  font3 = loadFont("CenturyGothic-Italic.vlw");
  textFont(font1, 12);
  
  int lijnGrafiek = 100;
  int yas = 515;
  int xas = 87;
  for (int i=0; i<31; i++){
    //grid xas
    stroke(0);
    strokeWeight(0);
    line(lijnGrafiek,100,lijnGrafiek,yHoogte);
    //labels xas
    String textx = str(i+1);
    Label labelx = new Label(textx, xas,525);
    xas += 20;
   
    // checkt of hij kleiner is dan 21, anders tekent hij geen lijnen meer
    if(i < 21){ 
      //grid yas
      line(100,lijnGrafiek,700,lijnGrafiek);
      //labels yas
      String texty = str(i*2);
      Label labely = new Label(texty, 70,yas);
      yas -= 20;
    }
    lijnGrafiek += 20;
  }
   textFont(font2, 25);
   Label titel = new Label("Temperatuur Eindhoven (augustus 2013)", 400,50);
   textFont(font2, 16);
   Label onderTitel = new Label("Maximum en Minimum", 400,75);
   textFont(font1, 12);
   Label temperatuur = new Label("Temperatuur (°C)", 70,80); 
   Label dagen = new Label("Dag van maand augustus", 650,550);
   textFont(font3, 12);
   Label bron = new Label("Bron: KNMI",50,580);
   textFont(font1, 12); 
}


// klasse voor een tekstlabel
class Label {
  
  Label(String txt, float x, float y) {
    
    // tekstbreedte ophalen
    float labelW = textWidth(txt);
    // tekst schrijven
    fill(0);
    text(txt, x+15, y-15);
    textAlign(CENTER,CENTER);
  }
}
