Shader "Hidden/DepthToWorldPos"
{
    Properties
    {
        _MainTex("", 2D) = ""{}
    }
    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass
        {
            CGPROGRAM

            #pragma vertex Vertex
            #pragma fragment Fragment
            #pragma target 3.5

            #include "Common.cginc"

            float4x4 _InverseView;
            float4x4 _ViewMatrix;

            half4 Fragment(Varyings input) : SV_Target
            {
                float3 vpos = ComputeViewSpacePosition(input);
                float3 wpos = mul(_InverseView, float4(vpos, 1)).xyz;
                return VisualizePosition(input, wpos);
            }

            ENDCG
        }
    }
}
