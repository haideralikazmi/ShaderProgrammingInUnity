Shader "Unlit/GridShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [IntRange] _GridSize ("GridSize", Range(1,20)) = 1
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

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _GridSize;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = fixed4(0,0,0,1);
                float2 scaledUV = i.uv * _GridSize;
                float2 fractionalUV = frac(scaledUV);
                if(fractionalUV.x <0.52 && fractionalUV.x > 0.48)
                {
                    col = fixed4(1,1,1,1); 
                }
                if(fractionalUV.y <0.52 && fractionalUV.y > 0.48)
                {
                    col = fixed4(1,1,1,1); 
                }
                
                return col;
            }
            ENDCG
        }
    }
}
