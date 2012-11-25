library tbot;

import 'dart:html';
import 'dart:math';
import 'dart:isolate';

part 'src/engine/service_manager.dart';
part 'src/engine/component.dart';
part 'src/engine/drawable_component.dart';
part 'src/engine/content_manager.dart';
part 'src/engine/mouse.dart';
part 'src/engine/util.dart';
part 'src/game/entity.dart';
part 'src/game/soldier.dart';

class Game {
  List<Component> components = [];
  ContentManager content;
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  ServiceManager services;
  Mouse mouse;

  // Game level size.
  int width = 2048;
  int height = 2048;

  // TODO: Implement Camera.

  Game(CanvasElement canvas) {
    this.canvas = canvas;
    context = canvas.getContext('2d');
    content = new ContentManager(this);
    services = new ServiceManager(this);
    mouse = new Mouse(this);

    loadContent();
  }

  /**
   * Loads the game content and after that runs the game.
   */
  loadContent() {
    content.loadAll({
      'background': 'images/background2.jpg',
      'soldier': 'images/soldier.png',
      'base': 'images/base.png'
    }).then((s) => run());
  }

  run() {
    // Add a soldier.
    var s = new Soldier(this)
      ..model = content.resources['soldier']
      ..x = 640.0
      ..y = 320.0
      ..canControl = true;

    components.add(s);

    // The main thread draws.
    window.requestAnimationFrame(draw);

    // Another thread for logic computation.
    // TODO: !
  }

  /**
   * The top-level draw loop.
   */
  draw(e) {
    context.clearRect(0, 0, canvas.width, canvas.height);

    // Draw the repeating background.
    for (var x = 0; x < width; x += 512) {
      for (var y = 0; y < height; y += 512) {
        context.drawImage(content.resources['background'], x, y);
      }
    }

    // Draw all drawable game components.
    components.forEach((Component c) {
      c.update(); // TODO: Temporarily update() here on main thread!

      if (c is DrawableComponent)
        c.draw();
    });

    window.requestAnimationFrame(draw);
  }
}