sampler2D input : register(s0);

float2 Warp(float2 Tex)
{
	float2 newPos = Tex;
	float c = -81.0/20.0;
	float u = Tex.x * 2.0 - 1.0;
	float v = Tex.y * 2.0 - 1.0;
	newPos.x = c*u/((v*v) + c);
	newPos.y = c*v/((u*u) + c);
	newPos.x = (newPos.x + 1.0)*0.5;
	newPos.y = (newPos.y + 1.0)*0.5;

	return newPos;
}

float4 main(float2 uv : TEXCOORD) : COLOR
{
	float4 color = tex2D(input, uv);
	float2 newPos = uv;

	if(uv.x<0.5){
			uv.x = uv.x * 2.0;
			color = tex2D(input, Warp(uv));
	}else{
			uv.x = (uv.x - 0.5) * 2.0;
			color = tex2D(input, Warp(uv));
	}

	return color;
}