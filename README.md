DepthInverseProjection
======================

![screenshot](http://i.imgur.com/4zjP6gQ.png)

This is an example that shows how to inverse-project depth samples (from [the
camera depth texture] into the view/world space in Unity.

[the camera depth texture]:
    https://docs.unity3d.com/Manual/SL-CameraDepthTexture.html

Notes
-----

- It uses [DrawProcedural] and [SV_VertexID semantics] in the vertex shader,
  so that it requires [shader compilation target] 3.5 at minimum. This is not
  essential but used to keep code simple and clean.
- Note that the camera space matches to the OpenGL convention (camera forward
  == negative Z).

[DrawProcedural]:
    https://docs.unity3d.com/ScriptReference/Graphics.DrawProcedural.html

[SV_VertexID semantics]:
    https://msdn.microsoft.com/en-us/library/windows/desktop/bb509647(v=vs.85).aspx

[shader compilation target]:
    https://docs.unity3d.com/Manual/SL-ShaderCompileTargets.html
