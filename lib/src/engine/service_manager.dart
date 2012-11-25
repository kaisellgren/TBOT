part of tbot;

class ServiceManager {
  Game game;
  List _services;

  ServiceManager(this.game);

  /**
   * Returns the given service.
   */
  get(Type t) {
    _services.forEach((service) {
      //if (service is t)
        //return service;
    });

    throw new Exception('Could not find service!');
  }
}