Shader "Unlit/GridShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        [IntRange] _GridSize ("GridSize", Range(1,20)) = 1
        _LineWidth ("LineWidth", Range(0,0.2)) = 0.05
        _Color ("LineColor", Color) = (0.1,0.1,0.1,1)
        _Opacity("LineOpacity", Range(0,1))= 1.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType" = "Transparent" }
        LOD 100

        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
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
            int _GridSize;
            float _LineWidth;
            fixed4 _Color;
            float _Opacity;

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
                if(fractionalUV.x <0.5+_LineWidth && fractionalUV.x > 0.48 -_LineWidth)
                {
                    col = _Color;
                    col.a = _Opacity;
                }
                if(fractionalUV.y <0.5 + _LineWidth && fractionalUV.y > 0.48-_LineWidth)
                {
                    col = _Color;
                    col.a = _Opacity;
                }
                
                return col;
            }
            ENDCG
        }
    }
}
