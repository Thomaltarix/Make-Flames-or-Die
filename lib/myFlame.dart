import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/particles.dart';
import 'dart:math' as math;

/* ----RANDOM---- */

double randomValueBetween(double min, double max) {
  return min + (math.Random().nextDouble() * (max - min));
}

double applyRandomnessDouble(double value, double randomness) {
  return value + (value * randomness * (math.Random().nextDouble() - 0.5));
}

Vector2 applyRandomnessVector2(Vector2 value, double randomness) {
  double x = value.x + (value.x * randomness * (math.Random().nextDouble() - 0.5));
  double y = value.y + (value.y * randomness * (math.Random().nextDouble() - 0.5));
  return value + Vector2(x, y);
}

/* ------------- */

class MyGame extends FlameGame {
  late Flame flame;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    flame = Flame(height: 1, width: 1, color: Colors.green, intensity: 5);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Add update logic here
    for (int i = 0; i < flame.intensity; i++) {
      add(ParticleSystemComponent(
        particle: flame.generateParticles(),
        position: Vector2(200, 700),
      ));
    }

  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Add render logic here
  }
}

/* ------------- */

class Flame {
  double height;
  double width;
  Color color;
  int intensity;

  Flame({required this.height, required this.width, required this.color, required this.intensity});

  AcceleratedParticle generateParticles() {
    // Add randomness to the color
    int colorShift = 75;
    int colorRandomShift = math.Random().nextInt(colorShift);
    int red = color.red + colorRandomShift - colorShift ~/ 2;
    int green = color.green + colorRandomShift - colorShift ~/ 2;
    int blue = color.blue + colorRandomShift - colorShift ~/ 2;

    // Ensure color values are within valid range
    red = red.clamp(0, 255);
    green = green.clamp(0, 255);
    blue = blue.clamp(0, 255);

    Color randomColor = Color.fromARGB(color.alpha, red, green, blue);


    // Add randomness to the direction
    double direction = math.Random().nextDouble() * width - width / 2.0; // random value between -width/2 and width/2

    // Adjust acceleration based on direction
    double accelerationX = direction * randomValueBetween(0.8, 1.2); // particles will accelerate towards the center proportional to their initial direction

    // Adjust lifespan based on direction
    double lifespan = height * (1 - (direction / width).abs()) * randomValueBetween(0.8, 1.2);

    return AcceleratedParticle(
      lifespan: lifespan,
      child: CircleParticle(
        radius: 3.0,
        paint: Paint()..color = randomColor,
      ),
      acceleration: Vector2(-25 * accelerationX, -100),
      speed: Vector2(50 * direction, 0), // particles will move a bit to the left or right
    );
  }
}

/* ------------- */