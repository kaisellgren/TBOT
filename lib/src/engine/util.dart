part of tbot;

/**
 * Converts radians to degrees.
 */
double radToDeg(double radians) {
  return radians * 180 / PI;
}

/**
 * Converts degrees to radians.
 */
double degToRad(double degrees) {
  return degrees * PI / 180;
}

/**
 * Returns the direction (in radians) from point to another.
 */
double getPointDirection(double x1, double y1, double x2, double y2) => atan2(y2 - y1, x2 - x1);

double getDistanceToPoint(double x1, double y1, double x2, double y2) {
  return sqrt((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
}