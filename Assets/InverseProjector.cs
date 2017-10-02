// Depth to view/world space inverse projection example
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class InverseProjector : MonoBehaviour
{
    enum Target { ViewSpace, WorldSpace }

    [SerializeField] Target _target = Target.ViewSpace;
    [SerializeField, Range(0, 1)] float _intensity = 0.5f;

    [SerializeField, HideInInspector] Shader _shader;
    Material _material;

    void Update()
    {
        GetComponent<Camera>().depthTextureMode = DepthTextureMode.Depth;
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (_material == null)
        {
            _material = new Material(_shader);
            _material.hideFlags = HideFlags.DontSave;
        }

        var matrix = GetComponent<Camera>().cameraToWorldMatrix;
        _material.SetMatrix("_InverseView", matrix);
        _material.SetFloat("_Intensity", _intensity);

        var pass = (_target == Target.ViewSpace) ? 0 : 1;
        Graphics.Blit(source, destination, _material, pass);
    }
}
