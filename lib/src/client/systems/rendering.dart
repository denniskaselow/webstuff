part of client;

class DevicePositionRenderingSystem extends WebGlRenderingSystem {
  Mapper<Position> pm;
  Mapper<DeviceRotation> drm;

  Uint16List indices;
  Float32List items;
  List<Attrib> attributes;

  int verticeCount = 4;
  int valuesPerVertex = 3;
  int trianglesPerObject = 2;

  DevicePositionRenderingSystem(RenderingContext gl)
      : super(gl, Aspect.getAspectForAllOf([Position, DeviceRotation])) {
    attributes = [new Attrib('aPos', 3)];
  }

  @override
  void processEntity(int index, Entity entity) {
    var p = pm[entity];
    var dr = drm[entity];
    var rot = dr.rot;// * 2.0 * PI / 360.0;
    var quat = new Quaternion.euler(rot.x, rot.y, rot.z);

    var itemOffset = index * valuesPerVertex * verticeCount;
    var indicesOffset = index * valuesPerVertex * trianglesPerObject;
    var offset = index * verticeCount;

    var rotPos = new Vector3(-0.1, -0.1, 0.0)..applyQuaternion(quat);
    items[itemOffset] = p.pos.x + rotPos.x;
    items[itemOffset + 1] = p.pos.y + rotPos.y;
    items[itemOffset + 2] = p.pos.z + rotPos.z;

    rotPos = new Vector3(0.1, -0.1, 0.0)..applyQuaternion(quat);
    items[itemOffset + 3] = p.pos.x + rotPos.x;
    items[itemOffset + 4] = p.pos.y + rotPos.y;
    items[itemOffset + 5] = p.pos.z + rotPos.z;

    rotPos = new Vector3(-0.1, 0.1, 0.0)..applyQuaternion(quat);
    items[itemOffset + 6] = p.pos.x + rotPos.x;
    items[itemOffset + 7] = p.pos.y + rotPos.y;
    items[itemOffset + 8] = p.pos.z + rotPos.z;

    rotPos = new Vector3(0.1, 0.1, 0.0)..applyQuaternion(quat);
    items[itemOffset + 9] = p.pos.x + rotPos.x;
    items[itemOffset + 10] = p.pos.y + rotPos.y;
    items[itemOffset + 11] = p.pos.z + rotPos.z;

    indices[indicesOffset] = offset;
    indices[indicesOffset + 1] = offset + 1;
    indices[indicesOffset + 2] = offset + 2;
    indices[indicesOffset + 3] = offset + 1;
    indices[indicesOffset + 4] = offset + 2;
    indices[indicesOffset + 5] = offset + 3;
  }

  @override
  void updateLength(int length) {
    items = new Float32List(length * valuesPerVertex * verticeCount);
    indices = new Uint16List(length * valuesPerVertex * trianglesPerObject);
  }

  @override
  void render(int length) {
    bufferElements(attributes, items, indices);
    gl.drawElements(TRIANGLES, indices.length, UNSIGNED_SHORT, 0);
  }

  @override
  String get vShaderFile => 'DevicePositionRenderingSystem';
  @override
  String get fShaderFile => 'DevicePositionRenderingSystem';
}
