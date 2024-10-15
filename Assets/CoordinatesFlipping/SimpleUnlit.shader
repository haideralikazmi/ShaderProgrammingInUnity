Shader "Unlit/SimpleUnlit"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Ymultiplier("Y-Multiplier", Integer) = 1
        _Xmultiplier("X-Multiplier", Integer) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            int _Ymultiplier;
            int _Xmultiplier;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = fixed4(0,0,0,1);
                float2 UV = i.uv;
                UV= UV - float2(0.5,0.5);
                UV.x *= _Xmultiplier;
                UV.y *= _Ymultiplier;
                if(UV.x > 0.2 && UV.x <0.35 && UV.y>0.2&& UV.y<0.35)
                {
                    col = fixed4(1,1,1,1);
                }
                return col;
            }
            ENDCG
        }
    }
}
