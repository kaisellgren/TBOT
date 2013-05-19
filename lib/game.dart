library tbot;

import 'dart:html';
import 'dart:math';
import 'dart:isolate';
import 'dart:collection';
import 'dart:async';

part 'src/engine/service_manager.dart';
part 'src/engine/component.dart';
part 'src/engine/drawable_component.dart';
part 'src/engine/content_manager.dart';
part 'src/engine/camera.dart';
part 'src/engine/mouse.dart';
part 'src/engine/keyboard.dart';
part 'src/engine/util.dart';
part 'src/engine/fps_counter.dart';

part 'src/game/entity.dart';
part 'src/game/soldier.dart';
part 'src/game/bush.dart';
part 'src/game/bullet.dart';
part 'src/game/clouds.dart';

class Game {
  List<Component> _components = [];
  ContentManager content;
  CanvasElement canvas;
  CanvasRenderingContext2D context;
  ServiceManager services;
  Camera camera;
  Mouse mouse;
  Keyboard keyboard;
  Random random = new Random();

  // Game level size.
  int width = 4096;
  int height = 4096;

  get componentCount => _components.length;

  Game(CanvasElement canvas) {
    this.canvas = canvas;
    context = canvas.getContext('2d');
    content = new ContentManager(this);
    services = new ServiceManager(this);
    camera = new Camera(this);
    mouse = new Mouse(this);
    keyboard = new Keyboard(this);

    loadContent();
  }

  /**
   * Loads the game content and after that runs the game.
   */
  loadContent() {
    content.loadAll({
      'background': 'images/background2.jpg',
      'soldier': 'images/soldier.png',
      'base': 'images/base.png',
      'bush01': 'images/bushes/bush01.png',
      'bush02': 'images/bushes/bush02.png',
      'bush03': 'images/bushes/bush03.png',
      'bush04': 'images/bushes/bush04.png',
      'bush05': 'images/bushes/bush05.png',
      'clouds': 'images/clouds.png',
    }).then((_) => run());
  }

  List<Component> _componentsToRemove = [];
  List<Component> _componentsToAdd = [];

  get team0players => _components.where((c) => c is Soldier && c.team == 0).toList().length;
  get team1players => _components.where((c) => c is Soldier && c.team == 1).toList().length;

  /**
   * Removes the given component [c] from the set of components in this game.
   */
  removeComponent(Component c) => _componentsToRemove.add(c);

  addComponent(Component c) => _componentsToAdd.add(c);

  _updateComponents() {
    _componentsToRemove.forEach((Component c) {
      var index = _components.indexOf(c);
      if (index != -1) _components.removeAt(index);
    });

    _componentsToAdd.forEach((Component c) {
      _components.add(c);

      // TODO: Let's find a better way
      _components.sort((a, b) {
        if (a is! DrawableComponent || b is! DrawableComponent) return 0;

        if (a.zIndex < b.zIndex)
          return -1;
        else if (a.zIndex > b.zIndex)
          return 1;
        else
          return 0;
      });
    });

    _componentsToRemove.clear();
    _componentsToAdd.clear();
  }

  run() {
    // Add a soldier.
    var s = new Soldier(this)
      ..model = content.resources['soldier']
      ..x = 640.0
      ..y = 320.0
      ..team = 0
      ..canControl = true;

    s.initialize();

    addComponent(s);

    // Spawn some AI soldiers.
    for (var i = 0; i < 1000; i++) {
      var team = i < 500 ? 0 : 1;

      var s = new Soldier(this)
        ..model = content.resources['soldier']
        ..team = team
        ..rotation = random.nextInt(360).toDouble();

      if (team == 0) {
        s
          ..x = random.nextInt(2048).toDouble()
          ..y = random.nextInt(2048).toDouble();
      } else {
        s
          ..x = 2048 + random.nextInt(2048).toDouble()
          ..y = 2048 + random.nextInt(2048).toDouble();
      }

      s.initialize();

      addComponent(s);
    }

    // Spawn some bushes.
    for (var i = 0; i < 50; i++) {
      var number = 1 + random.nextInt(5);

      var b = new Bush(this)
        ..model = content.resources['bush0$number']
        ..x = random.nextInt(width).toDouble()
        ..y = random.nextInt(height).toDouble()
        ..rotation = random.nextInt(360).toDouble();

      addComponent(b);
    }

    // The main thread draws.
    window.requestAnimationFrame(draw);

    // TODO: Another thread for logic computation.

    // Add FPS counter.
    addComponent(new FpsCounter(this));

    // Add clouds.
    var c = new Clouds(this)
      ..model = content.resources['clouds'];

    addComponent(c);

    addComponent(camera);

    camera.goTo(1200, 1600);
  }

  /**
   * The top-level draw loop.
   */
  draw(e) {
    context.clearRect(0, 0, canvas.width, canvas.height);

    // Draw the repeating background.
    for (var x = 0; x <= width; x += 512) {
      for (var y = 0; y <= height; y += 512) {
        context.drawImage(content.resources['background'], x, y);
      }
    }

    // Draw all drawable game components.
    _components.forEach((Component c) {
      c.update(); // TODO: Temporarily update() here on main thread!

      if (c is DrawableComponent)
        c.draw();
    });

    _updateComponents();

    window.requestAnimationFrame(draw);
  }
}