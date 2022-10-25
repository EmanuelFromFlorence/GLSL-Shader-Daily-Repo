/*
original_author: Patricio Gonzalez Vivo
description: given a Spherical Map texture and a normal direction returns the right pixel
use: spheremap(<sampler2D> texture, <float3> normal)
options:
  SPHEREMAP_EYETOPOINT: where the eye is looking
*/

#ifndef SPHEREMAP_EYETOPOINT
#define SPHEREMAP_EYETOPOINT float3(0.,0.,1.)
#endif


#ifndef SPHEREMAP_TYPE
#define SPHEREMAP_TYPE float4
#endif

#ifndef SPHEREMAP_SAMPLER_FNC
#define SPHEREMAP_SAMPLER_FNC(POS_UV) texture2D(tex, POS_UV)
#endif

#ifndef FNC_SPHEREMAP
#define FNC_SPHEREMAP
SPHEREMAP_TYPE sphereMap (in sampler2D tex, in float3 normal, in float3 eye) {
  float3 r = reflect( eye, normal );
	r.z += 1.;
  float m = 2. * length(r);
  vec2 uv = r.xy / m + .5;
  return SPHEREMAP_SAMPLER_FNC(uv);
}

#ifdef FNC_TEXTURE2D
SPHEREMAP_TYPE sphereMap (in SamplerVideo tex, in float3 normal, in float3 eye) {
  float3 r = reflect( eye, normal );
	r.z += 1.;
  float m = 2. * length(r);
  vec2 uv = r.xy / m + .5;
  return SPHEREMAP_SAMPLER_FNC(uv);
}
#endif
#endif
