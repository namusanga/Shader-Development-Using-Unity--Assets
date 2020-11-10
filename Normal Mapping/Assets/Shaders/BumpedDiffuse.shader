Shader "Custom/BumpedDiffuse"
{
	Properties
	{
		_myDiffuse("Diffuse Texture", 2D) = "white" {}
		_myBump("Bump Texture", 2D) = "bump" {}
		_mySlider("Bump Amount", Range(0,10)) = 1
		_myBrightness("Brightness", Range(0,10)) = 1
		_myCube("Cube Map",CUBE) = "white" {}
	}

		SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		//double the variables to have access to them in the CG LANG
		sampler2D _myDiffuse;
		sampler2D _myBump;
		half _mySlider;
		half _myBrightness;
		samplerCUBE _myCube;

		//Create our input structure
		struct Input {
			float2 uv_myDiffuse;
			float2 uv_myBump;
			float3 worldRefl;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			//o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
			o.Albedo = texCUBE(_myCube, IN.worldRefl).rbg;
			//o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump)) * _myBrightness;
			//o.Normal *= float3(_mySlider, _mySlider, 1);
		}
		ENDCG
	}
		Fallback "Diffuse"
}
