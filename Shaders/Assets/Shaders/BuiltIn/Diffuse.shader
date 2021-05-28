Shader "Shaders/BuiltIn/Diffuse"{
    Properties{
        _Color("Color",Color)=(1,1,1,1)
    }
    SubShader{
        Pass {
            Tags { "LightMode" = "ForwardBase" }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Lighting.cginc"

            fixed4 _Color;

            struct Attributes{
                float4 positionOS:POSITION;
                float3 normalOS:NORMAL;
            };

            struct Varyings{
                float4 positionCS:SV_POSITION;
                float3 normalWS:NORMAL;
            };

            Varyings vert(Attributes input){
                Varyings output;
                //The most fundamental and important task of a vertex shader is to transform vertices from Object Space to Clip Space
                output.positionCS = UnityObjectToClipPos(input.positionOS);
                //We need to transform normal from Object Space to World Space
                output.normalWS = normalize(mul(input.normalOS,(float3x3)unity_WorldToObject));
                return output;
            }

            //Compute diffuse color
            //Cdiffuse = ambient + light * diffuse + max(0,n dot l);
            fixed4 frag(Varyings input):SV_Target{
                fixed3 lightDirOS = normalize(_WorldSpaceLightPos0.xyz);
                fixed3 color = UNITY_LIGHTMODEL_AMBIENT.xyz + _LightColor0.rgb * _Color.rgb * saturate(dot(input.normalWS,lightDirOS));
                return fixed4(color,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
