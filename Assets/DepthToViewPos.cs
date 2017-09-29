using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class DepthToViewPos : MonoBehaviour
{
    [Range(0, 1)] public float _intensity = 0.5f;

    [SerializeField] Shader _shader;

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

        RenderTexture.active = destination;

        _material.SetTexture("_MainTex", source);
        _material.SetFloat("_Intensity", _intensity);
        _material.SetPass(0);

        Graphics.DrawProcedural(MeshTopology.Triangles, 3, 1);
    }
}
