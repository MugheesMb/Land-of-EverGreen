import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

// Represents a trail in the game world with a polygon hitbox.
class TrailPoly extends PositionComponent with CollisionCallbacks {
  final List<Vector2> vertices;

  TrailPoly({
    required this.vertices,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super(
    position: position, // Default position if not provided
    size: size,// Default size if not provided, might not be needed
    scale: scale,
    angle: angle,
    anchor: anchor, // Default anchor
  );
  /*{
    debugMode = true; // For development and debugging
  }*/

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final hitbox = PolygonHitbox(
      vertices,
      collisionType: CollisionType.passive,
      isSolid: true,
    );
    await add(hitbox);
  }
}