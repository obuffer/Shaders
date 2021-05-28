Shader "Shaders/URP/Diffuse"{
    Properties{
        _Color("Color",Color)=(1,1,1,1)
    }
    SubShader{
        Pass {
            Tags { 
                "RenderType" = "Opaque"
                "RenderPipeline" = "UniversalRenderPipeline" 
            }
            HLSLPROGRAM
            #pragma multi_compile_instancing
            #pragma vertex Vert
            #pragma fragment Frag
            #include "./DiffusePass.hlsl"
            ENDHLSL
        }
    }
}
