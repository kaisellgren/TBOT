part of tbot;

/**
 * Converts radians to degrees.
 */
double radToDeg(num radians) {
  return radians * 180 / PI;
}

/**
 * Converts degrees to radians.
 */
double degToRad(num degrees) {
  return degrees * PI / 180;
}

/**
 * Returns the direction (in radians) from point to another.
 */
double getPointDirection(num x1, num y1, num x2, num y2) => atan2(y2 - y1, x2 - x1);

/**
 * Returns the distance between the two given points.
 */
double getDistanceToPoint(num x1, num y1, num x2, num y2) => sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));