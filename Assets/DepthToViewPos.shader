Shader "Hidden/DepthToViewPos"
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

            half4 Fragment(Varyings input) : SV_Target
            {
                float3 vpos = ComputeViewSpacePosition(input);
                return VisualizePosition(input, vpos);
            }

            ENDCG
        }
    }
}
