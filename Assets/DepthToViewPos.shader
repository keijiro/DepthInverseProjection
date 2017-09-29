Shader "Hidden/DepthToViewPos"
{
    Properties
    {
        _MainTex("", 2D) = ""{}
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    sampler2D _MainTex;
    sampler2D _CameraDepthTexture;
    half _Intensity;

    struct Varyings
    {
        float4 position : SV_POSITION;
        float2 texcoord : TEXCOORD0;
        float3 ray : TEXCOORD1;
    };

    Varyings Vertex(uint vertexID : SV_VertexID)
    {
        float x = vertexID != 1 ? -1 : 3;
        float y = vertexID == 2 ? -3 : 1;
        float far = _ProjectionParams.z;

        Varyings o;
        o.position = float4(x, y, 1, 1);
        o.texcoord = float2((x + 1) / 2, (y + 1) / 2);
        o.ray = mul(unity_CameraInvProjection, o.position) * far;
        return o;
    }

    half4 Fragment(Varyings input) : SV_Target
    {
        float depth = SAMPLE_DEPTH_TEXTURE(_CameraDepthTexture, input.texcoord);
        float3 vpos = input.ray * Linear01Depth(depth);

        half4 source = tex2D(_MainTex, input.texcoord);
        half3 color = pow(abs(cos(vpos.xyz * UNITY_PI * 4)), 20);
        return half4(lerp(source.rgb, color, _Intensity), source.a);
    }

    ENDCG

    SubShader
    {
        Cull Off ZWrite Off ZTest Always
        Pass
        {
            CGPROGRAM
            #pragma vertex Vertex
            #pragma fragment Fragment
            ENDCG
        }
    }
}
