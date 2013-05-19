part of tbot;

class ContentManager {
  Game game;
  var resources = {};

  ContentManager(this.game);

  /**
   * Loads all given resources.
   */
  Future loadAll(Map resources) {
    var counter = 0;
    var completer = new Completer();

    isDone(e) {
      counter++;

      if (counter == resources.length)
        completer.complete();
    }

    resources.forEach((id, path) {
      var image = new ImageElement(src: path);
      this.resources[id] = image;
      image.onLoad.listen(isDone);
    });

    return completer.future;
  }
}