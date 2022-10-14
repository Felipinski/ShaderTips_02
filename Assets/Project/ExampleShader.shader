Shader "FeGameArt/Tutorial/ExampleShader"
{
    Properties
    {
        [Header(________________)]  
        [Header(Base material settings)]
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull", Float) = 0
        [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("Source blend", Int) = 1
        [Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("Destination blend", Int) = 0

        [Header(________________)]
        [Header(Main parameters)]
        _MainTex ("Texture", 2D) = "white" {}
        
        //Texture parameters
        //Scroll speed (.xy)
        //Color Intensity (.z)
        //Alpha Intensity (.w)
        _TextureParams ("Texture parameters", Vector) = (0, 0, 0, 0)
        
        [Header(________________)]

        [Header(Feature 01)]
        [Toggle(MULTIPLY_COLOR)] _UseMultiplyColor("Multiply color", Float) = 0
        _ColorToMultiply("Color to multiply", Color) = (1, 1, 1, 1)

        //Functions from shader graph
        //Attribute in inspector (Cull, Blend, etc)
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }
        LOD 100

        Cull[_Cull]
        Blend[_SrcBlend][_DstBlend]

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            //SHADER FEATURES
            #pragma shader_feature MULTIPLY_COLOR

            #include "UnityCG.cginc"

            #include "customFunctions.cginc"

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

            float4 _TextureParams;
            float4 _ColorToMultiply;

            v2f vert (appdata v)
            {
                v2f o;

                o.vertex = UnityObjectToClipPos(v.vertex);

                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uv += float2(_Time.y * _TextureParams.x, _Time.y * _TextureParams.y);

                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
            
                //Lerp between mapped color to black based on _TextureParams.z
                col.rgb = lerp(col.rgb, float3(0, 0, 0), saturate(1 - _TextureParams.z));
                //Set the alpha channel 
                col.a = saturate(_TextureParams.w);

#if MULTIPLY_COLOR
                //MultiplyColorRef(col, _ColorToMultiply);
                col = MultiplyColor(col, _ColorToMultiply);
#endif

                return col;
            }
            ENDCG
        }
    }
}
