part of client;

class DeviceWebGlCanvasCleaningSystem extends EntityProcessingSystem {
  Mapper<RenderTarget> rtm;
  DevicePositionRenderingSystem dprs;

  DeviceWebGlCanvasCleaningSystem()
      : super(Aspect.getAspectForAllOf([RenderTarget]));

  @override
  void processEntity(Entity entity) {
    var gl = rtm[entity].gl;
    gl.clearColor(0.0, 0.0, 0.0, 0.0);
    gl.clear(
        RenderingContext.COLOR_BUFFER_BIT | RenderingContext.DEPTH_BUFFER_BIT);
  }
  @override
  bool checkProcessing() => dprs.shaderSource != null;
}

class DevicePositionRenderingSystem extends EntitySystem {
  Mapper<Position> pm;
  Mapper<DeviceRotation> drm;
  Mapper<RenderTarget> rtm;

  Float32List posItems = new Float32List(12);

  GameHelper helper;
  ShaderSource shaderSource;

  DevicePositionRenderingSystem(this.helper)
      : super(
            Aspect.getAspectForAllOf([Position, DeviceRotation, RenderTarget]));

  @override
  void initialize() {
    helper.loadShader(vShaderFile, fShaderFile).then((shaderSource) {
      this.shaderSource = shaderSource;
    });
  }

  void initProgram(RenderTarget rt) {
    var vShader = _createShader(
        rt.gl, RenderingContext.VERTEX_SHADER, shaderSource.vShader);
    var fShader = _createShader(
        rt.gl, RenderingContext.FRAGMENT_SHADER, shaderSource.fShader);

    _createProgram(rt, vShader, fShader);
  }

  void _createProgram(RenderTarget rt, Shader vShader, Shader fShader) {
    var gl = rt.gl;
    var program = gl.createProgram();
    rt.program = program;
    gl.attachShader(program, vShader);
    gl.attachShader(program, fShader);
    gl.linkProgram(program);
    var linkSuccess =
        gl.getProgramParameter(program, RenderingContext.LINK_STATUS);
    if (!linkSuccess) {
      print(
          '${this.runtimeType} - Error linking program: ${gl.getProgramInfoLog(program)}');
    }
  }

  Shader _createShader(RenderingContext gl, int type, String source) {
    var shader = gl.createShader(type);
    gl.shaderSource(shader, source);
    gl.compileShader(shader);
    var compileSuccess =
        gl.getShaderParameter(shader, RenderingContext.COMPILE_STATUS);
    if (!compileSuccess) {
      print(
          '${this.runtimeType} - Error compiling shader: ${gl.getShaderInfoLog(shader)}');
    }
    return shader;
  }

  @override
  void processEntities(Iterable<Entity> entities) {
    entities.forEach((entity) {
      var rt = rtm[entity];
      if (rt.program == null) {
        initProgram(rt);
      }
      var gl = rt.gl;
      var program = rt.program;
      gl.useProgram(program);
      processEntity(0, entity);
      render(rt);
    });
  }

  void processEntity(int index, Entity entity) {
    var p = pm[entity];
    var dr = drm[entity];
    var rot = dr.rot * 2.0 * PI / 360.0;
    var quat = new Quaternion.euler(rot.x, rot.y, rot.z);

    var rotPos = new Vector3(-0.5, -0.8, 0.0)..applyQuaternion(quat);
    posItems[0] = p.pos.x + rotPos.x;
    posItems[1] = p.pos.y + rotPos.y;
    posItems[2] = p.pos.z + rotPos.z;

    rotPos = new Vector3(0.5, -0.8, 0.0)..applyQuaternion(quat);
    posItems[3] = p.pos.x + rotPos.x;
    posItems[4] = p.pos.y + rotPos.y;
    posItems[5] = p.pos.z + rotPos.z;

    rotPos = new Vector3(0.5, 0.8, 0.0)..applyQuaternion(quat);
    posItems[6] = p.pos.x + rotPos.x;
    posItems[7] = p.pos.y + rotPos.y;
    posItems[8] = p.pos.z + rotPos.z;

    rotPos = new Vector3(-0.5, 0.8, 0.0)..applyQuaternion(quat);
    posItems[9] = p.pos.x + rotPos.x;
    posItems[10] = p.pos.y + rotPos.y;
    posItems[11] = p.pos.z + rotPos.z;
  }

  void render(RenderTarget rt) {
    buffer(rt, 'aPos', posItems, 3);
    rt.gl.drawArrays(TRIANGLE_FAN, 0, posItems.length ~/ 3);
  }

  void buffer(RenderTarget rt, String attribute,
      Float32List items, int itemSize,
      {int usage: DYNAMIC_DRAW}) {
    var buffers = rt.buffers;
    var gl = rt.gl;
    var program = rt.program;
    var buffer = buffers[attribute];
    if (null == buffer) {
      buffer = gl.createBuffer();
      buffers[attribute] = buffer;
    }
    var attribLocation = gl.getAttribLocation(program, attribute);
    gl.bindBuffer(RenderingContext.ARRAY_BUFFER, buffer);
    gl.bufferData(RenderingContext.ARRAY_BUFFER, items, usage);
    gl.vertexAttribPointer(
        attribLocation, itemSize, RenderingContext.FLOAT, false, 0, 0);
    gl.enableVertexAttribArray(attribLocation);
  }

  String get vShaderFile => 'DevicePositionRenderingSystem';
  String get fShaderFile => 'DevicePositionRenderingSystem';
  @override
  bool checkProcessing() => shaderSource != null;
}
