part of client;

class RenderTarget extends Component {
  CanvasElement canvas;
  RenderingContext gl;
  Program program;
  Map<String, Buffer> buffers = <String, Buffer>{};
  bool initProgramCalled;
  RenderTarget(CanvasElement canvas)
      : this.canvas = canvas,
        this.gl = canvas.getContext3d(),
        this.initProgramCalled = false;
}
