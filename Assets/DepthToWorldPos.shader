Shader "Hidden/DepthToWorldPos"
{
    Properties
    {
        _MainTex ("-", 2D) = ""{}
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    sampler2D _MainTex;
    sampler2D_float _CameraDepthTexture;
    float4x4 _InverseView;
    half _Intensity;

    fixed4 frag (v2f_img i) : SV_Target
    {
        float vz = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, i.uv));
        float2 p11_22 = float2(unity_CameraProjection._11, unity_CameraProjection._22);
        float3 vpos = float3((i.uv * 2 - 1) / p11_22, -1) * vz;
        float4 wpos = mul(_InverseView, float4(vpos, 1));

        half4 source = tex2D(_MainTex, i.uv);
        half3 color = pow(abs(sin(wpos.xyz * UNITY_PI * 4)), 20);
        return half4(lerp(source.rgb, color, _Intensity), source.a);
    }

    ENDCG

    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass
        {
            CGPROGRAM
            #pragma vertex vert_img
            #pragma fragment frag
            ENDCG
        }
    }
}
