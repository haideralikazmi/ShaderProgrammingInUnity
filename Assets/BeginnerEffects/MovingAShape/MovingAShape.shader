Shader "Unlit/MovingAShape"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
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
            
            struct meshData
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
            
            v2f VertexFunction (meshData v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 FragmentFunction (v2f i) : SV_Target
            {
                fixed4 col = fixed4(0,0,0,1);
                float2 uv = i.uv;
                uv= uv - float2(0.5,0.5);
                uv.y += _Time.y * 0.3;
                uv.y = fmod(uv.y, 1.0);
                col = fixed4(uv.x,uv.y,0,1);
                if(uv.x > 0.2 && uv.x <0.35 && uv.y>0.2&& uv.y<0.35)
                {
                    col = fixed4(1,1,1,1);
                }
                return col;
            }
            ENDCG
        }
    }
}
