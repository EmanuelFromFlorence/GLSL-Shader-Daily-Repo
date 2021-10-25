varying vec2 vUv;
#define PI 3.14159265359
uniform float u_time;

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),
                             6.0)-3.0)-1.0,
                     0.0,
                     1.0 );
    rgb = rgb*rgb*(3.0-2.0*rgb);
    return c.z * mix(vec3(1.0), rgb, c.y);
}

mat2 Rot(float a){
    float s = sin(a);
    float c = cos(a);
    return mat2(c, -s, s, c);
}


void main(){
    vec2 vUv = vec2(vUv.x - 0.5, vUv.y - 0.5);
    vUv *= 5.0;
    float t = u_time * .05;
    vUv *= Rot(t * 10.0);
    vec3 color = vec3(0.);
    float angle = dot(cos(vUv.y * sin(u_time * 0.25)), cos(vUv.x * sin(u_time * 0.25)));
    float radius = length(vUv);
    color = 1. - hsb2rgb(vec3((angle * abs(tan(sin(u_time * 0.5)))) * radius, abs(tan(angle + u_time)) , radius * angle * u_time - 0.5));
    gl_FragColor = vec4(1. - color, 1.);
}