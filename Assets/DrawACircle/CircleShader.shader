Shader "Unlit/CircleShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Opacity("Opacity", Range(0,1))= 1.0
        _Radius ("CircleRadius", Range(0,1)) = 0.2
        _SmoothingFactor ("CircleSmoothingFactor", Range(0,0.1)) = 0.01
        
        
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
            float _Opacity;
            float _Radius;
            float _SmoothingFactor;

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
                float2 UV = i.uv;
                UV = UV - float2(0.5,0.5);
                float UVLength = length(UV);
                float increment = abs(sin(_Time.y)) *0.1;
                _Radius = _Radius + increment;
                float Value = smoothstep(_Radius,_Radius-_SmoothingFactor,UVLength);
                col = fixed4(1,1,1,1)*Value;
                if(UVLength>Value)
                {
                      col.a = _Opacity;
                }
                return col;
            }
            ENDCG
        }
    }
}
