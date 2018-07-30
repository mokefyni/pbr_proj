Shader "Custom/PBS/PBS_M4" {
    Properties {
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _Color ("Color", Color) = (0.0,0.0,0.0,1)
        _MainTex ("Base Color", 2D) = "white" {}
        _Metallic ("Metallic", Range(0, 1)) = 0
        _Gloss ("Gloss", Range(0, 1)) = 0.8

        [HideInInspector] _DebugMode("__debugMode", float) = 0.0
    }
    SubShader {
        Tags { "RenderType"="Opaque" }
        Pass {
            Name "FORWARD"
            Tags { "LightMode"="ForwardBase" }
             
            CGPROGRAM
            
            #pragma target 3.0

            #include "common/vert.cginc"
            #include "common/piexl.cginc"
            #pragma vertex vertForwardBase
            #pragma fragment fragForwardBase
            #define UNITY_PASS_FORWARDBASE
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
           
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog

            ENDCG
        }
        Pass
        {
            Name "ShadowCaster"
            Tags{ "LightMode" = "ShadowCaster" }

            ZWrite On ZTest LEqual

            CGPROGRAM
            #pragma target 3.0

            #include "UnityStandardShadow.cginc"
            #pragma vertex vertShadowCaster
            #pragma fragment fragShadowCaster

            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "PBRShaderGUI"
}