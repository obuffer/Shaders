#ifndef DIFFUSE_PASS_INCLUDE
#define DIFFUSE_PASS_INCLUDE
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/SpaceTransforms.hlsl"
#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
//if you want to use GPU Instancing,you should surround by Buffer
//to learn Dynamic Batching,SRP Batcher,GPU Instancing
UNITY_INSTANCING_BUFFER_START(UnityPerMaterial)
    UNITY_DEFINE_INSTANCED_PROP(half4,_Color)
UNITY_INSTANCING_BUFFER_END(UnityPerMaterial)

struct Attributes{
    float4 positionOS:POSITION;
    float3 normalOS:NORMAL;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct Varyings{
    float4 positionCS:SV_POSITION;
    float3 positionWS:VAR_POSITION;
    float3 normalWS:VAR_NORMAL;
    UNITY_VERTEX_INPUT_INSTANCE_ID
};

Varyings Vert(Attributes input){
    Varyings output;
    //This step just read INSTANCE ID from input to output
    UNITY_SETUP_INSTANCE_ID(input);
    UNITY_TRANSFER_INSTANCE_ID(input,output);
    
    output.positionCS = TransformObjectToHClip(input.positionOS.xyz);
    output.positionWS = TransformObjectToWorld(input.positionOS.xyz);
    //Smart you should know that for non-uniform scaling transformations of normals, you should use the inverse transpose matrix
    output.normalWS = TransformObjectToWorldNormal(input.normalOS);
    return output;
}

half4 Frag(Varyings input):SV_Target{
    UNITY_SETUP_INSTANCE_ID(input);
    Light light = GetMainLight();
    //you should use UNITY_ACCESS_INSTANCE_PRO() to access properties when using GPUInstancing
    float4 color = UNITY_ACCESS_INSTANCED_PROP(UnityPerMaterial,_Color);
    half3 result = UNITY_LIGHTMODEL_AMBIENT.rgb + light.color * color.rgb * saturate(dot(input.normalWS,light.direction));
    return half4(result,1);
}

#endif
