Includes = {
	"cw/pdxmesh_blendshapes.fxh"
	"cw/pdxmesh.fxh"
	"cw/utility.fxh"
	"cw/shadow.fxh"
	# MOD(agot)
	#"cw/camera.fxh" # MOD removed
	"cw/agot_camera.fxh"
	# END MOD
	"cw/alpha_to_coverage.fxh"
	"jomini/jomini_lighting.fxh"
	"jomini/jomini_fog.fxh"
	"jomini/portrait_accessory_variation.fxh"
	"jomini/portrait_coa.fxh"
	"jomini/portrait_decals.fxh"
	"jomini/portrait_user_data.fxh"
	"jomini/portrait_hair_lighting.fxh"
	"jomini/portrait_lighting.fxh"
	"constants.fxh"
	# MOD(godherja)
	"standardfuncsgfx.fxh"
	#"gh_portrait_effects.fxh"
	"gh_portrait_constants.fxh"
	"gh_portrait_decals_shared.fxh"
	
	# END MOD
}

PixelShader =
{
	TextureSampler DiffuseMap
	{
		Index = 0
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Wrap"
		SampleModeV = "Wrap"
	}
	TextureSampler PropertiesMap
	{
		Index = 1
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Wrap"
		SampleModeV = "Wrap"
	}
	TextureSampler NormalMap
	{
		Index = 2
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Wrap"
		SampleModeV = "Wrap"
	}
	TextureSampler SSAOColorMap
	{
		Index = 3
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Wrap"
		SampleModeV = "Wrap"
	}
	TextureSampler EnvironmentMap
	{
		Ref = JominiEnvironmentMap
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Clamp"
		SampleModeV = "Clamp"
		Type = "Cube"
	}
	TextureSampler DiffuseMapOverride
	{
		Index = 9
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Wrap"
		SampleModeV = "Wrap"
	}
	TextureSampler NormalMapOverride
	{
		Index = 10
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Wrap"
		SampleModeV = "Wrap"
	}
	TextureSampler PropertiesMapOverride
	{
		Index = 11
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Wrap"
		SampleModeV = "Wrap"
	}
	TextureSampler CoaTexture 
	{
		Index = 12
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Clamp"
		SampleModeV = "Clamp"
	}
	TextureSampler AnisotropyHairMap
	{
		Index = 13
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Wrap"
		SampleModeV = "Wrap"
	}
	TextureSampler ShadowTexture
	{
		Ref = PdxShadowmap
		MagFilter = "Linear"
		MinFilter = "Linear"
		MipFilter = "Linear"
		SampleModeU = "Clamp"
		SampleModeV = "Clamp"
		CompareFunction = less_equal
		SamplerType = "Compare"
	}

	VertexStruct PS_COLOR_SSAO
	{
		float4 Color : PDX_COLOR0;
		float4 SSAOColor : PDX_COLOR1;
	};
}

VertexStruct VS_OUTPUT_PDXMESHPORTRAIT
{
    float4 	Position		: PDX_POSITION;
	float3 	Normal			: TEXCOORD0;
	float3 	Tangent			: TEXCOORD1;
	float3 	Bitangent		: TEXCOORD2;
	float2 	UV0				: TEXCOORD3;
	float2 	UV1				: TEXCOORD4;
	float2 	UV2				: TEXCOORD5;
	float3 	WorldSpacePos	: TEXCOORD6;
	float4 	ShadowProj		: TEXCOORD7;
	# This instance index is used to fetch custom user data from the Data[] array (see pdxmesh.fxh)
	uint 	InstanceIndex	: TEXCOORD8;
	# MOD(godherja)
	# Cannot use bool because OpenGL doesn't support it, apparently.
	uint GH_IsDynamicTerrainLoaded : TEXCOORD9;
	# END MOD
};

VertexStruct VS_INPUT_PDXMESHSTANDARD_ID
{
    float3 Position			: POSITION;
	float3 Normal      		: TEXCOORD0;
	float4 Tangent			: TEXCOORD1;
	float2 UV0				: TEXCOORD2;
@ifdef PDX_MESH_UV1     	
	float2 UV1				: TEXCOORD3;
@endif
@ifdef PDX_MESH_UV2
	float2 UV2				: TEXCOORD4;
@endif


	uint2 InstanceIndices 	: TEXCOORD5;
	
@ifdef PDX_MESH_SKINNED
	uint4 BoneIndex 		: TEXCOORD6;
	float3 BoneWeight		: TEXCOORD7;
@endif

	uint VertexID			: PDX_VertexID;
};

# MOD(godherja)
# This definition has been moved to gh_portrait_constants.fxh because
# in Godherja it's also needed by terrain shaders.
# Any changes to this definition should also be applied to that file.

# Portrait constants (SPortraitConstants)
#ConstantBuffer( 5 )
#{
#	float4 		vPaletteColorSkin;
#	float4 		vPaletteColorEyes;
#	float4 		vPaletteColorHair;
#	float4		vSkinPropertyMult;
#	float4		vEyesPropertyMult;
#	float4		vHairPropertyMult;
#	
#	float4 		Light_Color_Falloff[3];
#	float4 		Light_Position_Radius[3]
#	float4 		Light_Direction_Type[3];
#	float4 		Light_InnerCone_OuterCone_AffectedByShadows[3];
#	
#	int			DecalCount;
#	int         PreSkinColorDecalCount
#	int			TotalDecalCount;
#	int 		_; // Alignment
#
#	float4 		PatternColorOverrides[16];
#	float4		CoaColor1;
#	float4		CoaColor2;
#	float4		CoaColor3;
#	float4		CoaOffsetAndScale;
#
#	float		HasDiffuseMapOverride;
#	float		HasNormalMapOverride;
#	float		HasPropertiesMapOverride;
#};
	
# END MOD

VertexShader = {

	Code
	[[
		VS_OUTPUT_PDXMESHPORTRAIT ConvertOutput( VS_OUTPUT_PDXMESH In )
		{
			VS_OUTPUT_PDXMESHPORTRAIT Out;
			
			Out.Position = In.Position;
			Out.Normal = In.Normal;
			Out.Tangent = In.Tangent;
			Out.Bitangent = In.Bitangent;
			Out.UV0 = In.UV0;
			Out.UV1 = In.UV1;
			Out.UV2 = In.UV2;
			Out.WorldSpacePos = In.WorldSpacePos;
			return Out;
		}
	]]
	
	
	MainCode VS_standard
	{
		Input = "VS_INPUT_PDXMESHSTANDARD"
		Output = "VS_OUTPUT_PDXMESHPORTRAIT"
		Code
		[[
			PDX_MAIN
			{
				VS_OUTPUT_PDXMESHPORTRAIT Out = ConvertOutput( PdxMeshVertexShaderStandard( Input ) );
				Out.InstanceIndex = Input.InstanceIndices.y;

				// MOD(godherja)
				#ifdef GH_PORTRAIT_SKIN
					Out.GH_IsDynamicTerrainLoaded = GH_AreTerrainMarkerDecalsLoaded() ? 1 : 0;
				#else
					Out.GH_IsDynamicTerrainLoaded = 1;
				#endif // !GH_PORTRAIT_SKIN
				// END MOD

				return Out;
			}
		]]
	}
}

PixelShader =
{
	Code
	[[
		void DebugReturn( inout float3 Out, SMaterialProperties MaterialProps, SLightingProperties LightingProps, PdxTextureSamplerCube EnvironmentMap, float3 ScatteringColor, float ScatteringMask, float3 DiffuseTranslucency )
		{
			#if defined( PDX_DEBUG_PORTRAIT_SCATTERING_MASK )
				Out = ScatteringMask;
			#elif defined( PDX_DEBUG_PORTRAIT_SCATTERING_COLOR )
				Out = ScatteringColor;
			#elif defined( PDX_DEBUG_TRANSLUCENCY )
				Out = DiffuseTranslucency;
			#else
			DebugReturn( Out, MaterialProps, LightingProps, EnvironmentMap );
			#endif
		}

		float3 CommonPixelShader( float4 Diffuse, float4 Properties, float3 NormalSample, in VS_OUTPUT_PDXMESHPORTRAIT Input )
		{
			#define PORTRAIT_WIDGET

			float3x3 TBN = Create3x3( normalize( Input.Tangent ), normalize( Input.Bitangent ), normalize( Input.Normal ) );
			float3 Normal = normalize( mul( NormalSample, TBN ) );
			
			SMaterialProperties MaterialProps = GetMaterialProperties( Diffuse.rgb, Normal, saturate( Properties.a ), Properties.g, Properties.b );
			SLightingProperties LightingProps = GetSunLightingProperties( Input.WorldSpacePos, ShadowTexture );
			
			float3 DiffuseIBL;
			float3 SpecularIBL;
			CalculateLightingFromIBL( MaterialProps, LightingProps, EnvironmentMap, DiffuseIBL, SpecularIBL );
			
			float3 DiffuseLight = vec3(0.0);
			float3 SpecularLight = vec3(0.0);
			CalculatePortraitLights( Input.WorldSpacePos, LightingProps._ShadowTerm, MaterialProps, DiffuseLight, SpecularLight );
			
			float3 Color = DiffuseIBL + SpecularIBL + DiffuseLight + SpecularLight;
			
			#ifdef VARIATIONS_ENABLED
				ApplyClothFresnel( Input, CameraPosition, Normal, Color );
			#endif
			
			float3 ScatteringColor = vec3(0.0f);
			float ScatteringMask = Properties.r;
			#ifdef FAKE_SCATTERING_EMISSIVE
				float3 SkinColor = RGBtoHSV( Diffuse.rgb );
				SkinColor.z = 1.0f;
				ScatteringColor = HSVtoRGB(SkinColor) * ScatteringMask * 0.5f * MaterialProps._DiffuseColor;
				Color += ScatteringColor;
			#endif

			float3 DiffuseTranslucency = vec3( 0.0f );
			#ifdef TRANSLUCENCY
				STranslucencyProperties TranslucencyProps;
				#if defined( SKIN_SCATTERING )
				float3 SkinColor = RGBtoHSV( Diffuse.rgb );
				SkinColor.z = 1.0f;
					ScatteringColor = HSVtoRGB( SkinColor ) * MaterialProps._DiffuseColor;
					TranslucencyProps = GetTranslucencyProperties( 0.3f, 2.0f, 1.0f, 1.0f, 0.2f, ScatteringMask, ScatteringColor );
				#elif defined( THICKNESS_MAP )
					TranslucencyProps = GetTranslucencyProperties( 0.3f, 1.5f, 1.0f, 1.0f, 0.2f, Properties.r, Diffuse.rgb );
				#else
					TranslucencyProps = GetTranslucencyProperties( 0.3f, 1.5f, 1.0f, 1.0f, 0.2f, 0.5f, Diffuse.rgb );
				#endif
				DiffuseTranslucency = CalculatePortraitTranslucentLights( Input.WorldSpacePos, LightingProps._ShadowTerm, MaterialProps, TranslucencyProps, DiffuseIBL );
				Color += DiffuseTranslucency;
			#endif
			
			//EK2 EMISSIVE SHADER
			//Use for emissive in normal BLUE channel.
			#ifdef EMISSIVE_NORMAL_BLUE

				float EmissiveStrength = 1.0f;
				float emissiveMask = PdxTex2D( NormalMap, Input.UV0 ).b;
				float3 emissiveColor = Diffuse.rgb * EmissiveStrength;
				Color = lerp(Color, emissiveColor, emissiveMask);

			#endif
			
			//Use for emissive in properties RED channel.
			#ifdef EMISSIVE_PROPERTIES_RED

				float EmissiveStrength = 1.0f;
				float emissiveMask = Properties.r;
				float3 emissiveColor = Diffuse.rgb * EmissiveStrength;
				Color = lerp(Color, emissiveColor, emissiveMask);
			#endif
			//EK2 EMISSIVE SHADER
			Color = ApplyDistanceFog( Color, Input.WorldSpacePos );
			
			DebugReturn( Color, MaterialProps, LightingProps, EnvironmentMap, ScatteringColor, ScatteringMask, DiffuseTranslucency );
			return Color;
		}

		// Remaps Value to [IntervalStart, IntervalEnd]
		// Assumes Value is in [0,1] and that 0 <= IntervalStart < IntervalEnd <= 1
		float RemapToInterval( float Value, float IntervalStart, float IntervalEnd )
		{
			return IntervalStart + Value * ( IntervalEnd - IntervalStart );
		}

		// The skin, eye and hair assets come with a special texture  (the "Color Mask", typically packed into 
		// another texture) that determines the Diffuse-PaletteColor blend. Artists also supply a remap interval 
		// used to bias this texture's values; essentially allowing the texture's full range of values to be 
		// mapped into a small interval of the diffuse lerp (e.g. [0.8, 1]).
		// If the texture value is 0.0, that is a special case indicating there shouldn't be any palette color, 
		// (it is used for non-hair things such as hair bands, earrings etc)
		float3 GetColorMaskColorBLend( float3 DiffuseColor, float3 PaletteColor, uint InstanceIndex, float ColorMaskStrength )
		{
			if ( ColorMaskStrength == 0.0 )
			{
				return DiffuseColor;
			}
			else
			{
				float2 Interval = GetColorMaskRemapInterval( InstanceIndex );
				float LerpTarget = RemapToInterval( ColorMaskStrength, Interval.x, Interval.y );
				return lerp( DiffuseColor.rgb, DiffuseColor.rgb * PaletteColor, LerpTarget );
			}
		}
	]]

	MainCode PS_skin
	{
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PS_COLOR_SSAO"
		Code
		[[
			PDX_MAIN
			{			
				PS_COLOR_SSAO Out;

				float2 UV0 = Input.UV0;
				float4 Diffuse;
				float4 Properties;
				float3 NormalSample;

				//EK2
				float3 SkinColorPalette = vPaletteColorSkin.rgb;

				#ifdef SKIN_TO_HAIR_COLOR
				SkinColorPalette = vPaletteColorHair.rgb;
				#endif
				//END-EK2	

            #ifdef ENABLE_TEXTURE_OVERRIDE
				if ( HasDiffuseMapOverride > 0.5f )
				{
                    Diffuse = PdxTex2D( DiffuseMapOverride, UV0 );
				}
				else
				{
					Diffuse = PdxTex2D( DiffuseMap, UV0 );
				}
				if ( HasPropertiesMapOverride > 0.5f )
				{
                    Properties = PdxTex2D( PropertiesMapOverride, UV0 );
				}
				else
				{
					Properties = PdxTex2D( PropertiesMap, UV0 );
				}
				if ( HasNormalMapOverride > 0.5f )
				{
                    NormalSample = UnpackRRxGNormal( PdxTex2D( NormalMapOverride, UV0 ) );
				}
				else
				{
					NormalSample = UnpackRRxGNormal( PdxTex2D( NormalMap, UV0 ) );
				}
            #else
				Diffuse = PdxTex2D( DiffuseMap, UV0 );
				Properties = PdxTex2D( PropertiesMap, UV0 );
				NormalSample = UnpackRRxGNormal( PdxTex2D( NormalMap, UV0 ) );
			#endif


				//EK2
				
				float ColorMaskStrength = Diffuse.a;
				#ifndef NO_DECAL
				AddDecals( Diffuse, NormalSample, Properties, UV0, Input.InstanceIndex, 0, PreSkinColorDecalCount,0 );
				#endif

				//Get the DecalData for the decal containing above colour in Mip6
				//DecalData Data = GetDecalData(MAGENTA, DIFFUSE_DECAL, DecalCount);
				DecalData Data = GetDecalData(MAGENTA, DIFFUSE_DECAL, DecalCount, Input.GH_IsDynamicTerrainLoaded != 0);

				//Set Weight to be the transperancy/strength of the above decal
				float Weight = Data._Weight;

				SkinColorPalette = lerp(vPaletteColorSkin.rgb,vPaletteColorHair.rgb,Weight);


				//Diffuse.rgb = GetColorMaskColorBLend( Diffuse.rgb, vPaletteColorSkin.rgb, Input.InstanceIndex, ColorMaskStrength );
				Diffuse.rgb = GetColorMaskColorBLend( Diffuse.rgb, SkinColorPalette, Input.InstanceIndex, ColorMaskStrength );
				//END-EK2


				//EK2
				#ifndef NO_DECAL
				AddDecals( Diffuse, NormalSample, Properties, UV0, Input.InstanceIndex, PreSkinColorDecalCount, DecalCount,0 );
				#endif
				//EK2
				
				float3 Color = CommonPixelShader( Diffuse, Properties, NormalSample, Input );
				Out.Color = float4( Color, 1.0f );

				Out.SSAOColor = PdxTex2D( SSAOColorMap, UV0 );

				//EK2
				//Out.SSAOColor.rgb *= vPaletteColorSkin.rgb;
				Out.SSAOColor.rgb *= SkinColorPalette;
				//END-EK2
				return Out;
			}
			
		]]
	}
	
	MainCode PS_eye
	{
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PS_COLOR_SSAO"
		Code
		[[
			PDX_MAIN
			{
				PS_COLOR_SSAO Out;

				float2 UV0 = Input.UV0;
				float4 Diffuse = PdxTex2D( DiffuseMap, UV0 );								
				float4 Properties = PdxTex2D( PropertiesMap, UV0 );
				float3 NormalSample = UnpackRRxGNormal( PdxTex2D( NormalMap, UV0 ) );
				
				//EK2
				#ifdef EYE_DECAL

					float4 BaseDiffuse = Diffuse;

					AddDecals( Diffuse, NormalSample, Properties, UV0, Input.InstanceIndex, 0, PreSkinColorDecalCount, BODYPART_EYES, Input.GH_IsDynamicTerrainLoaded != 0);

					Diffuse.rgb = lerp(Diffuse,BaseDiffuse,BaseDiffuse.a).rgb;
				#endif
				

				float3 EyeColor = vPaletteColorEyes.rgb;

				#ifdef HSV_SHIFT
					EyeColor = RGBtoHSV(EyeColor);
					EyeColor.x = EyeColor.x + 0.5f;
					EyeColor = saturate(HSVtoRGB(EyeColor));
				#endif

				float ColorMaskStrength = Diffuse.a;

				#ifndef EYE_BLIND
				
					Diffuse.rgb = GetColorMaskColorBLend( Diffuse.rgb, EyeColor.rgb, Input.InstanceIndex, ColorMaskStrength );

					#ifdef EYE_DECAL
						AddDecals( Diffuse, NormalSample, Properties, UV0, Input.InstanceIndex, PreSkinColorDecalCount, DecalCount, BODYPART_EYES, Input.GH_IsDynamicTerrainLoaded != 0);
					#endif
					
				#endif
				//END-EK2
				
				float3 Color = CommonPixelShader( Diffuse, Properties, NormalSample, Input );
				Out.Color = float4( Color, 1.0f );
				
				Out.SSAOColor = PdxTex2D( SSAOColorMap, UV0 );
				Out.SSAOColor.rgb *= vPaletteColorEyes.rgb;
	
				return Out;
			}
		]]
	}

	#EK2
		MainCode PS_skin_alpha
	{
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PS_COLOR_SSAO"
		Code
		[[
			PDX_MAIN
			{
				PS_COLOR_SSAO Out;

				float2 UV0 = Input.UV0;
				float4 Diffuse = PdxTex2D( DiffuseMap, UV0 );								
				float4 Properties = PdxTex2D( PropertiesMap, UV0 );
				float3 NormalSample = UnpackRRxGNormal( PdxTex2D( NormalMap, UV0 ) );
				
				float ColorMaskStrength = Diffuse.a;
				Diffuse.rgb = GetColorMaskColorBLend( Diffuse.rgb, vPaletteColorSkin.rgb, Input.InstanceIndex, ColorMaskStrength );
				
				float3 Color = CommonPixelShader( Diffuse, Properties, NormalSample, Input );
				Out.Color = float4( Color, 1.0f );
				
				Out.SSAOColor = PdxTex2D( SSAOColorMap, UV0 );
				Out.SSAOColor.rgb *= vPaletteColorSkin.rgb;
	
				return Out;
			}
		]]
	}
	#END-EK2

	MainCode PS_attachment
	{		
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PS_COLOR_SSAO"
		Code
		[[
			PDX_MAIN
			{
				PS_COLOR_SSAO Out;

				float2 UV0 = Input.UV0;
				float4 Diffuse = PdxTex2D( DiffuseMap, UV0 );								
				float4 Properties = PdxTex2D( PropertiesMap, UV0 );
				
				#ifdef DOUBLE_SIDED_ENABLED
					float4 NormalSampleRaw = PdxTex2D( NormalMap, UV0 );
					float3 NormalSample = UnpackRRxGNormal( NormalSampleRaw ) * ( PDX_IsFrontFace ? 1 : -1 );
				#else
				float3 NormalSample = UnpackRRxGNormal( PdxTex2D( NormalMap, UV0 ) );		
				#endif
				
				#if defined( VARIATIONS_ENABLED ) || defined ( COA_ENABLED )
				Properties.r = 1.0; // wipe this clean now, ready to be modified later
				#endif
				

				#ifdef VARIATIONS_ENABLED
					ApplyVariationPatterns( Input, Diffuse, Properties, NormalSample );

				//EK2
				#else
					#ifdef ATTACHEMENT_DECAY

					//Get the DecalData for the decal containing above colour in Mip6
					//DecalData Data = GetDecalData(RED, DIFFUSE_DECAL, DecalCount);
					DecalData Data = GetDecalData(RED, DIFFUSE_DECAL, DecalCount, Input.GH_IsDynamicTerrainLoaded != 0);

					//Set Weight to be the transperancy/strength of the above decal
					float Weight = Data._Weight;
					uint DiffuseIndex = Data._DiffuseIndex;

					//R - WET MASK
					//G - THICK DIRT MASK
					//B - RUST MASK
					//A - WORN FABRIC MASK
					float4 DiffuseDecayMask2x = PdxTex2D( DecalDiffuseArray, float3( Input.UV0*2.0f, DiffuseIndex ) );
					float4 DiffuseDecayMask3x = PdxTex2D( DecalDiffuseArray, float3( Input.UV0*3.0f, DiffuseIndex ) );

					//RUST
					float3 RustMask = float3(0.4f,0.2f,0.13f);
					RustMask = RustMask * (DiffuseDecayMask3x.bbb);
					RustMask = Overlay( Diffuse.rgb, RustMask,1.0f );

					float ClothMask = smoothstep(1.0f-float(Properties.b*2.0f),1.0f-Properties.b,0.8f);
					float RustRoughness = DiffuseDecayMask2x.b*DiffuseDecayMask3x.b;

					Diffuse.rgb = lerp(Diffuse.rgb,RustMask,smoothstep(DiffuseDecayMask2x.b,DiffuseDecayMask2x.b+0.2f,Weight*0.8f)*ClothMask);
					Properties.a = lerp(Properties.a,1.0f,smoothstep(RustRoughness,RustRoughness+0.3f,Weight*0.4)*smoothstep(1.0f-float(Properties.a*2.0f),1.0f-Properties.a,0.8f)*ClothMask);

					//Worn out fabrics
					 float FabricMask = saturate(0.6f-DiffuseDecayMask2x.a);

					 Diffuse.rgb = lerp(Diffuse.rgb,float3(0.9f,0.75f,0.6f),smoothstep(FabricMask,FabricMask+0.3f,(Weight*0.34f)*(1.0f-ClothMask)*0.7f));
					
					 Properties.b = lerp(Properties.b,0.0f,smoothstep(FabricMask,FabricMask+0.3f,(Weight*0.4f)*(1.0f-ClothMask)));
					 Properties.a = lerp(Properties.a,1.0f,smoothstep(FabricMask,FabricMask+0.3f,(Weight*0.4f)*(1.0f-ClothMask)));

					//Holes in fabrics
					 float WearMask = abs(0.8f-DiffuseDecayMask2x.a);
					 Diffuse.a = lerp(Diffuse.a,0.0f,step(WearMask,Weight*0.3f)*(1.0f-ClothMask));

					//Stains in fabric
					float StainMask = saturate(DiffuseDecayMask3x.r*5.0f);
					Diffuse.rgb = Multiply(Diffuse.rgb,float3(StainMask,StainMask,StainMask), clamp(Weight*2.0f,0.0f,1.0f));


					//Layers of dirt
					float DirtMask = clamp( NormalSample.b * NormalSample.b, 0, 1 );
					DirtMask = max(DirtMask,DiffuseDecayMask3x.g*1.5);
					float3 DirtDiffuse = float3(0.2f,0.1f,0.06f);
				
					
					DirtDiffuse *= Diffuse.rgb;
					Diffuse.rgb = lerp(Diffuse.rgb,DirtDiffuse,smoothstep(DirtMask*0.5f,DirtMask*1.5f,clamp(Weight*1.6f,0.0f,1.0f)));

					#endif
					//EK2

				#endif
				#ifdef COA_ENABLED
					ApplyCoa( Input, Diffuse, CoaColor1, CoaColor2, CoaColor3, CoaOffsetAndScale.xy, CoaOffsetAndScale.zw, CoaTexture, Properties.r );
				#endif

				float3 Color = CommonPixelShader( Diffuse, Properties, NormalSample, Input );


				#if defined PARALLAX || defined REFRACT
					Out.Color = float4( Color, 1.0f );
				#else
				Out.Color = float4( Color, Diffuse.a );
				#endif

				Out.SSAOColor = float4( vec3( 0.0f ), 1.0f );

				return Out;
			}
		]]
	}
	MainCode PS_portrait_hair_backface
	{
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PDX_COLOR"
		Code
		[[
			PDX_MAIN
			{			
				return float4( vec3( 0.0f ), 1.0f );
			}
		]]
	}
	MainCode PS_hair
	{
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PS_COLOR_SSAO"
		Code
		[[
			PDX_MAIN
			{
				PS_COLOR_SSAO Out;

				float2 UV0 = Input.UV0;
				float4 Diffuse = PdxTex2D( DiffuseMap, UV0 );								
				float4 Properties = PdxTex2D( PropertiesMap, UV0 );
				Properties *= vHairPropertyMult;
				float4 NormalSampleRaw = PdxTex2D( NormalMap, UV0 );
				float3 NormalSample = UnpackRRxGNormal( NormalSampleRaw ) * ( PDX_IsFrontFace ? 1 : -1 );

				float ColorMaskStrength = NormalSampleRaw.b;
				Diffuse.rgb = GetColorMaskColorBLend( Diffuse.rgb, vPaletteColorHair.rgb, Input.InstanceIndex, ColorMaskStrength );
				
				//EK2 - Salt n' Pepper
				#ifdef HAIR_AGING_DECAL

				//Get the DecalData for the decal containing above colour in Mip6
				//DecalData Data = GetDecalData(GREEN, DIFFUSE_DECAL, DecalCount);
				DecalData Data = GetDecalData(GREEN, DIFFUSE_DECAL, DecalCount, Input.GH_IsDynamicTerrainLoaded != 0);

				//Get base hair texture
				float4 BaseDiffuse = PdxTex2D( DiffuseMap, UV0 );	

				//Set Weight to be the transperancy/strength of the above decal
				float Weight = Data._Weight;

				//Interpolate between the original white hair texture and the final coloured texture using Weight as strength value to create salt and pepper effect.
				Diffuse.rgb = lerp (Diffuse.rgb, BaseDiffuse.ggg, step((1.0f - Weight) , saturate(BaseDiffuse.r)) * Diffuse.a * (Weight ) * 0.7f);	

				#endif	
				//END-EK2

				float3 Color = CommonPixelShader( Diffuse, Properties, NormalSample, Input );

				#ifdef ALPHA_TO_COVERAGE
					Diffuse.a = RescaleAlphaByMipLevel( Diffuse.a, UV0, DiffuseMap );

					const float CUTOFF = 0.5f;
					Diffuse.a = SharpenAlpha( Diffuse.a, CUTOFF );
				#endif

				#ifdef WRITE_ALPHA_ONE
					Out.Color = float4( Color, 1.0f );
				#else
					#ifdef HAIR_TRANSPARENCY_HACK
						// TODO [HL]: Hack to stop clothing fragments from being discarded by transparent hair,
						// proper fix is to ensure that hair is drawn after clothes
						// https://beta.paradoxplaza.com/browse/PSGE-3103
						clip( Diffuse.a - 0.5f );
					#endif

					Out.Color = float4( Color, Diffuse.a );
				#endif

				Out.SSAOColor = PdxTex2D( SSAOColorMap, UV0 );
				Out.SSAOColor.rgb *= vPaletteColorHair.rgb;

				return Out;
			}
		]]
	}
	MainCode PS_hair_double_sided
	{
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PS_COLOR_SSAO"
		Code
		[[
			PDX_MAIN
			{
				PS_COLOR_SSAO Out;

				float2 UV0 = Input.UV0;
				float4 Diffuse = PdxTex2D( DiffuseMap, UV0 );
				#ifdef ALPHA_TEST
				clip( Diffuse.a - 0.5f );
				Diffuse.a = 1.0f;
				#endif
				float4 Properties = PdxTex2D( PropertiesMap, UV0 );
				float3 NormalSample = UnpackRRxGNormal( PdxTex2D( NormalMap, UV0 ) );

				Properties *= vHairPropertyMult;
				Diffuse.rgb *= vPaletteColorHair.rgb;

				float3 Color = CommonPixelShader( Diffuse, Properties, NormalSample, Input );

				Out.Color = float4( Color, Diffuse.a );
				
				Out.SSAOColor = PdxTex2D( SSAOColorMap, UV0 );
				Out.SSAOColor.rgb *= vPaletteColorHair.rgb;

				return Out;
			}
		]]
	}


	MainCode PS_anisotropic_hair
	{
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PS_COLOR_SSAO"
		Code
		[[
			#ifndef DIFFUSE_UV_SET
			#define DIFFUSE_UV_SET Input.UV0
			#endif
			#ifndef NORMAL_UV_SET
			#define NORMAL_UV_SET Input.UV0
			#endif
			#ifndef PROPERTIES_UV_SET
			#define PROPERTIES_UV_SET Input.UV0
			#endif	
			#ifndef ANISOTROPY_UV_SET
			#define ANISOTROPY_UV_SET Input.UV0
			#endif
			#ifndef FLOWMAP_UV_SET
			#define FLOWMAP_UV_SET Input.UV0
			#endif
			
			SCharacterHairSettings GetCharacterHairSettings()
			{
				SCharacterHairSettings HairSettings;
				HairSettings._EdgeColor = float4( vPaletteColorHair.rgb * 0.1f, 1.0f );
				HairSettings._StrandDirection = float3( 0.0f, -1.0f, 0.0f );
				HairSettings._PrimaryHighlightShift = -0.5f;
				HairSettings._AnisotropyShiftScale = float2( 1.0f, 1.0f );
				HairSettings._AnisotropySmoothnessMin = 0.0f;
				HairSettings._AnisotropySmoothnessMax = 1.0f;
				HairSettings._SecondaryHighlightShift = -0.9f;
				HairSettings._NormalStrength = 1.0f;
				float SpecularPowerScale = ( vPaletteColorHair.r + vPaletteColorHair.g + vPaletteColorHair.b ) / 3;
				SpecularPowerScale = lerp( 1.0f ,3.0f , SpecularPowerScale );
				HairSettings._SpecularPower = 5.0f * SpecularPowerScale;
				HairSettings._AlphaCutoffTreshold = 0.5f;
				HairSettings._RoughnessMin = 0.0f;
				HairSettings._RoughnessMax = 1.0f;
				return HairSettings;
			}

			PDX_MAIN
			{
				float4 NormalSampleRaw = PdxTex2D( NormalMap, NORMAL_UV_SET );
				float3 UnpackedNormal = UnpackRRxGNormal( NormalSampleRaw ) * ( PDX_IsFrontFace ? 1 : -1 );
				float3x3 TBN = Create3x3( normalize( Input.Tangent ), normalize( Input.Bitangent ), normalize( Input.Normal ) );
				float3 Normal = normalize( mul( UnpackedNormal, TBN ) );

				SCharacterHairSettings HairSettings = GetCharacterHairSettings();

				float4 Diffuse = PdxTex2D( DiffuseMap, DIFFUSE_UV_SET );

				float3 HairBaseDiffuse;

				float ColorMaskStrength = NormalSampleRaw.b;
				HairBaseDiffuse.rgb = GetColorMaskColorBLend( Diffuse.rgb, vPaletteColorHair.rgb, Input.InstanceIndex, ColorMaskStrength );

				float4 Properties = PdxTex2D( PropertiesMap, PROPERTIES_UV_SET );
				Properties *= vHairPropertyMult;
				float AnisotropyShift = PdxTex2D( AnisotropyHairMap, ANISOTROPY_UV_SET * HairSettings._AnisotropyShiftScale ).b;
				AnisotropyShift = lerp( HairSettings._AnisotropySmoothnessMin, HairSettings._AnisotropySmoothnessMax, AnisotropyShift );

				SMaterialProperties MaterialProps = GetMaterialProperties( HairBaseDiffuse, Normal, saturate( lerp( HairSettings._RoughnessMin, HairSettings._RoughnessMax, Properties.a ) ), Properties.g + 0.01f, Properties.b );
				SLightingProperties LightingProps = GetSunLightingProperties( Input.WorldSpacePos, ShadowTexture );

				//The specular will stretch along the input tangent. This can be provided via a flowmap or a vector.
				#ifdef USE_FLOWMAP
					float3 Flow = float3( PdxTex2D( AnisotropyHairMap, FLOWMAP_UV_SET ).rg, 0.0f );
					Flow.rg = Flow.rg * 2.0f - 1.0f;
					Flow.g = -Flow.g;
					float3 T = normalize( mul( Flow, TBN ) );
				#else
					float3 T = normalize( mul( HairSettings._StrandDirection, TBN ) );
				#endif

				float3 N = lerp( Input.Normal, Normal, HairSettings._NormalStrength );

				//Hair mainly produces two highlights. The primary highlight which reflects the light color and the secondary highlight which also reflects some of the hair color in addition to the light color.
				//We shift them slightly manually to fake the light scattering effect.
				float3 T1 = ShiftTangent( T, N, HairSettings._PrimaryHighlightShift + AnisotropyShift );
				float3 T2 = ShiftTangent( T, N, HairSettings._SecondaryHighlightShift + AnisotropyShift );

				SHairProperties HairProps;
				HairProps._UVs = DIFFUSE_UV_SET;
				HairProps._PrimaryTangent = T1;
				HairProps._SecondaryTangent = T2;
				HairProps._EdgeColor = HairSettings._EdgeColor.rgb;
				HairProps._SpecularPower = HairSettings._SpecularPower;
				HairProps._SmoothnessMin = HairSettings._AnisotropySmoothnessMin;
				HairProps._SmoothnessMax = HairSettings._AnisotropySmoothnessMax;
				HairProps._ColorMaskStrength = ColorMaskStrength;

				float3 Color = CalculateHairLighting( Input.Position.xy, Input.WorldSpacePos, MaterialProps, LightingProps, HairProps, EnvironmentMap );

				#ifdef ALPHA_TO_COVERAGE
					Diffuse.a = RescaleAlphaByMipLevel( Diffuse.a, DIFFUSE_UV_SET, DiffuseMap );
					Diffuse.a = SharpenAlpha( Diffuse.a, HairSettings._AlphaCutoffTreshold );
				#endif
				#ifdef HAIR_TRANSPARENCY_HACK
					clip( Diffuse.a - 0.5f );
				#endif

				float Alpha = Diffuse.a;

				PS_COLOR_SSAO Out;
				Out.Color = float4( Color.rgb, Alpha );
				Out.SSAOColor = PdxTex2D( SSAOColorMap, DIFFUSE_UV_SET );
				Out.SSAOColor.rgb *= vPaletteColorHair.rgb;
				return Out;
			}
		]]
	}

	#MOD-AGOT
	MainCode PS_dragon
	{
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PS_COLOR_SSAO"
		Code
		[[
			PDX_MAIN
			{
				PS_COLOR_SSAO Out;

				float2 UV0 = Input.UV0;
				float2 UV1 = Input.UV1;
				float4 Diffuse = PdxTex2D( DiffuseMap, UV0 );								
				float4 Properties = PdxTex2D( PropertiesMap, UV0 );
				float4 NormalSampleRaw = PdxTex2D( NormalMap, UV0 );
				float3 NormalSample = UnpackRRxGNormal( NormalSampleRaw ) * ( PDX_IsFrontFace ? 1 : -1 );
				float4 ColorMask = PdxTex2D( SSAOColorMap, UV0 );

				// float3 DragonSkinColor = 		float3(0.0f,0.0f,0.0f);
				// float3 DragonHighlightColor = 	float3(0.0f,0.0f,0.0f);
				// float3 DragonEyeColor = 		float3(0.0f,0.0f,0.0f);
				// float3 DragonHornColor = 		float3(0.0f,0.0f,0.0f);

				// GetDragonPalettes( DragonSkinColor, DragonHighlightColor, DragonHornColor, DragonEyeColor );

				// float3 ColorPalette = float3(1.0f,1.0f,1.0f);

				// ColorPalette = lerp(ColorPalette,DragonSkinColor,ColorMask.r);
				// ColorPalette = lerp(ColorPalette,DragonHornColor,ColorMask.g);
				// ColorPalette = lerp(ColorPalette,DragonHighlightColor,ColorMask.b);
				// ColorPalette = lerp(ColorPalette,DragonEyeColor,ColorMask.a);

				// ColorMask.a = 1.0f;

				// Diffuse.rgb = GetColorMaskColorBLend( Diffuse.rgb, ColorPalette, Input.InstanceIndex, ColorMask.a );
				#ifdef DECALS
					AddDragonDecals( Diffuse, NormalSample, Properties, ColorMask, UV0, UV1, Input.InstanceIndex );
				#endif
				
				float3 Color = CommonPixelShader( Diffuse, Properties, NormalSample, Input );

				#ifdef ALPHA_TO_COVERAGE
					Diffuse.a = RescaleAlphaByMipLevel( Diffuse.a, UV0, DiffuseMap );

					const float CUTOFF = 0.5f;
					Diffuse.a = SharpenAlpha( Diffuse.a, CUTOFF );
				#endif

				#ifdef WRITE_ALPHA_ONE
					Out.Color = float4( Color, 1.0f );
				#else
					#ifdef HAIR_TRANSPARENCY_HACK
						// TODO [HL]: Hack to stop clothing fragments from being discarded by transparent hair,
						// proper fix is to ensure that hair is drawn after clothes
						// https://beta.paradoxplaza.com/browse/PSGE-3103
						clip( Diffuse.a - 0.5f );
					#endif

					Out.Color = float4( Color, Diffuse.a );
				#endif

				Out.SSAOColor = float4(0.0f,0.0f,0.0f,0.0f);
				return Out;
			}
		]]
	}

	MainCode PS_dragon_shadow
	{
		Input = "VS_OUTPUT_PDXMESHPORTRAIT"
		Output = "PS_COLOR_SSAO"
		Code
		[[
			PDX_MAIN
			{
				PS_COLOR_SSAO Out;
				Out.Color = float4( 0.0f,0.0f,0.0f,0.5f);
				Out.SSAOColor = float4(0.0f,0.0f,0.0f,0.0f);
				return Out;
			}
		]]
	}
	#END-MOD
}

BlendState hair_alpha_blend
{
	BlendEnable = yes
	SourceBlend = "SRC_ALPHA"
	DestBlend = "INV_SRC_ALPHA"
	SourceAlpha = "ONE"
	DestAlpha = "INV_SRC_ALPHA"
	WriteMask = "RED|GREEN|BLUE|ALPHA"
}

DepthStencilState hair_alpha_blend
{
	DepthWriteEnable = no
}

BlendState alpha_to_coverage
{
	BlendEnable = yes
	SourceBlend = "SRC_ALPHA"
	DestBlend = "INV_SRC_ALPHA"
	WriteMask = "RED|GREEN|BLUE|ALPHA"
	SourceAlpha = "ONE"
	DestAlpha = "INV_SRC_ALPHA"
	AlphaToCoverage = yes
}

#Mod AGOT
DepthStencilState DepthStencilDragon
{
	DepthEnable = yes
	DepthWriteEnable = no
}

#End Mod

RasterizerState rasterizer_no_culling
{
	CullMode = "none"
}
RasterizerState rasterizer_back_culling
{
	CullMode = "back"
}
RasterizerState rasterizer_backfaces
{
	FrontCCW = yes
}
RasterizerState ShadowRasterizerState
{
	#Don't go higher than 10000 as it will make the shadows fall through the mesh
	DepthBias = 500
	SlopeScaleDepthBias = 2
}
RasterizerState ShadowRasterizerStateBackfaces
{
	DepthBias = 1000
	SlopeScaleDepthBias = 2
	FrontCCW = yes
}

Effect portrait_skin
{
	VertexShader = "VS_standard"
	PixelShader = "PS_skin"
	# MOD(godherja)
	#Defines = { "SKIN_SCATTERING" "TRANSLUCENCY" "PDX_MESH_BLENDSHAPES" }
	Defines = { "SKIN_SCATTERING" "TRANSLUCENCY" "PDX_MESH_BLENDSHAPES" "GH_PORTRAIT_SKIN" "PORTRAIT_WIDGET"}
	# END MOD
}

Effect portrait_skinShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_teeth
{
	VertexShader = "VS_standard"
	PixelShader = "PS_skin"
	Defines = { "SKIN_SCATTERING" "TRANSLUCENCY" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}


Effect portrait_skin_face
{
	VertexShader = "VS_standard"
	PixelShader = "PS_skin"
	# MOD(godherja)
	#Defines = { "FAKE_SSS_EMISSIVE" "ENABLE_TEXTURE_OVERRIDE" "PDX_MESH_BLENDSHAPES" }
	Defines = { "SKIN_SCATTERING" "TRANSLUCENCY" "ENABLE_TEXTURE_OVERRIDE" "PDX_MESH_BLENDSHAPES" "GH_PORTRAIT_SKIN" "PORTRAIT_WIDGET"}
	# END MOD
}

Effect portrait_skin_faceShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDXMESH_DISABLE_DITHERED_OPACITY" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_eye
{
	VertexShader = "VS_standard"
	PixelShader = "PS_eye"
	Defines = { "EMISSIVE_PROPERTIES_RED" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	Defines = { "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachmentShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDXMESH_DISABLE_DITHERED_OPACITY" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_pattern
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	Defines = { "VARIATIONS_ENABLED" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_patternShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDXMESH_DISABLE_DITHERED_OPACITY" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_pattern_alpha_to_coverage
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	BlendState = "alpha_to_coverage"
	Defines = { "VARIATIONS_ENABLED" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_pattern_alpha_to_coverageShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_variedShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_alpha_to_coverage
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	BlendState = "alpha_to_coverage"
	Defines = { "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_alpha_to_coverageShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_with_coa
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	Defines = { "COA_ENABLED" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_with_coaShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDXMESH_DISABLE_DITHERED_OPACITY" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_alpha_to_coverage_with_coa
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	BlendState = "alpha_to_coverage"
	Defines = { "COA_ENABLED" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_alpha_to_coverage_with_coaShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET" }
}

Effect portrait_attachment_with_coa_and_variations
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	Defines = { "COA_ENABLED" "VARIATIONS_ENABLED" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_with_coa_and_variationsShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDXMESH_DISABLE_DITHERED_OPACITY" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_alpha_to_coverage_with_coa_and_variations
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	BlendState = "alpha_to_coverage"
	Defines = { "COA_ENABLED" "VARIATIONS_ENABLED" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_alpha_to_coverage_with_coa_and_variationsShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_hair
{
	VertexShader = "VS_standard"
	PixelShader = "PS_hair"
	BlendState = "alpha_to_coverage"
	RasterizerState = "rasterizer_no_culling"
	Defines = { "ALPHA_TO_COVERAGE" "PDX_MESH_BLENDSHAPES" "HAIR_AGING_DECAL" "PORTRAIT_WIDGET"}
}

Effect portrait_hair_transparency_hack
{
	VertexShader = "VS_standard"
	PixelShader = "PS_hair"
	BlendState = "alpha_to_coverage"
	RasterizerState = "rasterizer_no_culling"
	Defines = { "HAIR_TRANSPARENCY_HACK" "PDX_MESH_BLENDSHAPES" "HAIR_AGING_DECAL" "PORTRAIT_WIDGET"}
}

Effect portrait_hairShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDXMESH_DISABLE_DITHERED_OPACITY" "PORTRAIT_WIDGET"}
}

Effect portrait_hair_double_sided
{
	VertexShader = "VS_standard"
	PixelShader = "PS_hair_double_sided"
	BlendState = "alpha_to_coverage"
	#DepthStencilState = "test_and_write"
	RasterizerState = "rasterizer_no_culling"
	Defines = { "PDX_MESH_BLENDSHAPES" "HAIR_AGING_DECAL" "PORTRAIT_WIDGET"}
}

Effect portrait_hair_alpha
{
	VertexShader = "VS_standard"
	PixelShader = "PS_hair"
	BlendState = "hair_alpha_blend"
	DepthStencilState = "hair_alpha_blend"
	Defines = { "PDX_MESH_BLENDSHAPES" "HAIR_AGING_DECAL" "PORTRAIT_WIDGET"}
}

Effect portrait_hair_decrease_specular_light_alpha
{
	VertexShader = "VS_standard"
	PixelShader = "PS_hair"
	BlendState = "hair_alpha_blend"
	DepthStencilState = "hair_alpha_blend"
	Defines = { "PDX_MESH_BLENDSHAPES" "PDX_DECREASE_SPECULAR_LIGHT" }
}

Effect portrait_hair_opaque
{
	VertexShader = "VS_standard"
	PixelShader = "PS_hair"
	
	Defines = { "WRITE_ALPHA_ONE" "PDX_MESH_BLENDSHAPES" "HAIR_AGING_DECAL" "PORTRAIT_WIDGET"}
}

Effect portrait_hair_opaqueShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDXMESH_DISABLE_DITHERED_OPACITY" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_alpha
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	BlendState = "hair_alpha_blend"
	DepthStencilState = "hair_alpha_blend"
	Defines = { "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_alphaShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_hair_backside
{
	VertexShader = "VS_standard"
	PixelShader = "PS_portrait_hair_backface"
	RasterizerState = "rasterizer_backfaces"
	Defines = { "HAIR_AGING_DECAL" "PORTRAIT_WIDGET"}
}
Effect portrait_anisotropic_hair
{
	VertexShader = "VS_standard"
	PixelShader = "PS_anisotropic_hair"
	BlendState = "alpha_to_coverage"
	RasterizerState = "rasterizer_no_culling"
	Defines = { "ALPHA_TO_COVERAGE" "PDX_MESH_BLENDSHAPES" "USE_FLOWMAP" }
}

Effect portrait_anisotropic_hairShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDXMESH_DISABLE_DITHERED_OPACITY" }
}

Effect portrait_anisotropic_hair_no_flow
{
	VertexShader = "VS_standard"
	PixelShader = "PS_anisotropic_hair"
	BlendState = "alpha_to_coverage"
	RasterizerState = "rasterizer_no_culling"
	Defines = { "ALPHA_TO_COVERAGE" "PDX_MESH_BLENDSHAPES" }
}

Effect portrait_anisotropic_hair_no_flowShadow
{
	VertexShader = "VertexPdxMeshStandardShadow"
	PixelShader = "PixelPdxMeshStandardShadow"
	RasterizerState = "ShadowRasterizerState"
	Defines = { "PDXMESH_DISABLE_DITHERED_OPACITY" }
}
#AGOT
Effect portrait_skin_no_decal
{
	VertexShader = "VS_standard"
	PixelShader = "PS_skin"
	Defines = { "FAKE_SSS_EMISSIVE" "PDX_MESH_BLENDSHAPES" "NO_DECAL"}
}

#EK2
Effect skin_alpha
{
	VertexShader = "VS_standard"
	PixelShader = "PS_skin_alpha"
	Defines = {"PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET"}
}

Effect portrait_skin_hair_color
{
	VertexShader = "VS_standard"
	PixelShader = "PS_skin"
	Defines = {"PDX_MESH_BLENDSHAPES" "FAKE_SSS_EMISSIVE" "SKIN_TO_HAIR_COLOR" "GH_PORTRAIT_SKIN" "PORTRAIT_WIDGET"}
}

Effect portrait_eye_no_decal
{
	VertexShader = "VS_standard"
	PixelShader = "PS_eye"
	Defines = {"PDX_MESH_BLENDSHAPES" "EMISSIVE_PROPERTIES_RED" "PORTRAIT_WIDGET"}
}

Effect portrait_eye_shift
{
	VertexShader = "VS_standard"
	PixelShader = "PS_eye"
	Defines = {"PDX_MESH_BLENDSHAPES" "EMISSIVE_PROPERTIES_RED" "EYE_DECAL" "HSV_SHIFT" "PORTRAIT_WIDGET"}
}

Effect portrait_eye_blind
{
	VertexShader = "VS_standard"
	PixelShader = "PS_eye"
	Defines = {"PDX_MESH_BLENDSHAPES" "EYE_DECAL" "EYE_BLIND" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_refract
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	#BlendState = "hair_alpha_blend"
	#DepthStencilState = "hair_alpha_blend"
	Defines = { "PDX_MESH_BLENDSHAPES" "EMISSIVE_NORMAL_BLUE" "ATTACHEMENT_DECAY" "REFRACT" "PORTRAIT_WIDGET"}
}

Effect portrait_attachment_pattern_refract
{
	VertexShader = "VS_standard"
	PixelShader = "PS_attachment"
	#BlendState = "hair_alpha_blend"
	#DepthStencilState = "hair_alpha_blend"
	Defines = {"PDX_MESH_BLENDSHAPES" "VARIATIONS_ENABLED" "EMISSIVE_NORMAL_BLUE" "ATTACHEMENT_DECAY" "REFRACT" "PORTRAIT_WIDGET"}
}
#END-EK2

#MOD-AGOT
Effect portrait_dragon
{
	VertexShader = "VS_standard"
	PixelShader = "PS_dragon"
	Defines = { "ALPHA_TO_COVERAGE" "PDX_MESH_BLENDSHAPES" "EMISSIVE_PROPERTIES_RED" "PORTRAIT_WIDGET"}
}

Effect portrait_dragon_shadow
{
	VertexShader = "VS_standard"
	PixelShader = "PS_dragon_shadow"
	RasterizerState = "ShadowRasterizerState"
	DepthStencilState = DepthStencilDragon
	Defines = { "ALPHA_TO_COVERAGE" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET" "SHADOW_HACK"}
}

Effect portrait_dragon_decals
{
	VertexShader = "VS_standard"
	PixelShader = "PS_dragon"
	Defines = { "ALPHA_TO_COVERAGE" "PDX_MESH_BLENDSHAPES" "EMISSIVE_PROPERTIES_RED" "DECALS" "PORTRAIT_WIDGET"}
}

Effect portrait_dragon_decals_shadow
{
	VertexShader = "VS_standard"
	PixelShader = "PS_dragon_shadow"
	RasterizerState = "ShadowRasterizerState"
	DepthStencilState = DepthStencilDragon
	Defines = { "ALPHA_TO_COVERAGE" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET" "SHADOW_HACK"}
}

Effect portrait_dragon_wing_decals
{
	VertexShader = "VS_standard"
	PixelShader = "PS_dragon"
	RasterizerState = "rasterizer_no_culling"
	Defines = { "ALPHA_TO_COVERAGE" "PDX_MESH_BLENDSHAPES" "EMISSIVE_PROPERTIES_RED" "DECALS" "PORTRAIT_WIDGET"}
}

Effect portrait_dragon_wing_decals_shadow
{
	VertexShader = "VS_standard"
	PixelShader = "PS_dragon_shadow"
	RasterizerState = "ShadowRasterizerState"
	DepthStencilState = DepthStencilDragon
	Defines = { "ALPHA_TO_COVERAGE" "PDX_MESH_BLENDSHAPES" "PORTRAIT_WIDGET" "SHADOW_HACK"}
}
#END-MOD
