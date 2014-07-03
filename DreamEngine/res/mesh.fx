float4x4 g_mWorld;                  // World matrix for object
float4x4 g_mWorldViewProjection;    // World * View * Projection matrix

texture Tex;

sampler S0 = sampler_state
{
    Texture   = (Tex);
    MinFilter = LINEAR; 
    MagFilter = LINEAR; 
    MipFilter = LINEAR;
};

struct VS_OUTPUT
{
    float4 Position   : POSITION0;   // vertex position 
    float2 TextureUV  : TEXCOORD0;  // vertex texture coords 
};
VS_OUTPUT mainVS( float4 vPos : POSITION0, 
                  float3 vNormal : NORMAL0,
                  float2 vTexCoord0 : TEXCOORD0
                  )
{
		VS_OUTPUT outPut;
		outPut.Position = mul(vPos,g_mWorld);
		outPut.Position = mul(outPut.Position,g_mWorldViewProjection);
		outPut.TextureUV = vTexCoord0;
		return outPut;
}

struct PS_OUTPUT
{
    float4 color : COLOR0;  // Pixel color    
};

PS_OUTPUT mainPS(VS_OUTPUT inPut)
{
	 PS_OUTPUT outPut;
	 outPut.color = tex2D(S0,inPut.TextureUV);
	 return outPut;
}

technique SBTechnique
{
	pass P0
	{
		  VertexShader = compile vs_2_0 mainVS();
      PixelShader  = compile ps_2_0 mainPS();
	}
}