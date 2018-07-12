using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[System.Serializable]
[PostProcess(typeof(InverseProjectionRenderer), PostProcessEvent.AfterStack, "Test/Inverse Projection")]
public sealed class InverseProjection : PostProcessEffectSettings
{
    public enum Target { ViewSpace, WorldSpace }

    [System.Serializable]
    public sealed class TargetParameter : ParameterOverride<Target> {}

    public TargetParameter target = new TargetParameter();

    [Range(0, 1)] public FloatParameter opacity = new FloatParameter();
}

public sealed class InverseProjectionRenderer : PostProcessEffectRenderer<InverseProjection>
{
    static class ShaderIDs
    {
        internal static readonly int Opacity = Shader.PropertyToID("_Opacity");
        internal static readonly int InverseView = Shader.PropertyToID("_InverseView");
    }

    public override DepthTextureMode GetCameraFlags()
    {
        return DepthTextureMode.Depth;
    }

    public override void Render(PostProcessRenderContext context)
    {
        var cmd = context.command;
        cmd.BeginSample("Inverse Projection");

        var sheet = context.propertySheets.Get(Shader.Find("Hidden/Test/InverseProjection"));
        sheet.properties.SetFloat(ShaderIDs.Opacity, settings.opacity);
        sheet.properties.SetMatrix(ShaderIDs.InverseView, context.camera.cameraToWorldMatrix);

        var pass = (int)settings.target.value;
        cmd.BlitFullscreenTriangle(context.source, context.destination, sheet, pass);

        cmd.EndSample("Inverse Projection");
    }
}
