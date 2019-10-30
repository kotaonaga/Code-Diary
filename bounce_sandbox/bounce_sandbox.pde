import processing.serial.*;
import cc.arduino.*;

final int debounceDelay = 50;
final int buttonPin = 2;
Arduino a;

int lastButtonState = a.LOW;
int lastDebounceTime = 0;
int count = 0;

void setup() {
  size(400, 400);
  surface.setLocation(displayWidth - 400, 0);
  a = new Arduino(this, "/dev/cu.usbserial-141140", 57600);
  a.pinMode(buttonPin, a.INPUT);
}

void draw() {
  background(0);
  int buttonState = a.digitalRead(buttonPin);
  if (lastButtonState == a.LOW && buttonState == a.HIGH) {
    int now = millis();
    println("count "+count);
    println("lastDebounceTime "+lastDebounceTime);
    println(now - lastDebounceTime);
    println((now - lastDebounceTime) > debounceDelay);
    if ((now - lastDebounceTime) > debounceDelay) {
      count++;
    }
    lastDebounceTime = now;
  }
  lastButtonState = buttonState;


  if (count == 0) {
    background(255);
    fill(250, 0, 0);
    ellipse(width/2, height/2, 200, 200);
  } else if (count == 1) {
    background(255);
    fill(200, 0, 0);
    ellipse(width/2, height/2, 200, 200);
  }else if(count == 2){
    fill(150, 0, 0);
    ellipse(width/2, height/2, 200, 200);
  }
}
