Shader "Unlit/RandonNumber"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex VertexFunction
            #pragma fragment FragmentFunction

            #include "UnityCG.cginc"


            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float RandomNumberGenerator(float2 input)
            {
                input = frac(input * float2(2233.4,243.1));
                input+= dot(input, input + 34.23);
                return frac(input.x * input.y);
            }

            v2f VertexFunction (MeshData v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 FragmentFunction (v2f i) : SV_Target
            {
                i.uv += _Time.y;
                fixed4 color = _Color * RandomNumberGenerator(i.uv);
                return color;
            }
            
            ENDCG
        }
    }
}
