varying vec2 vUv;
#define PI 3.14159265359
#define TWO_PI 6.28318530718
uniform float u_time;

vec2 random2(vec2 st){
    st=vec2(dot(st,vec2(127.1,311.7)),
    dot(st,vec2(269.5,183.3)));
    return-1.+2.*fract(sin(st)*43758.5453123);
}

// Gradient Noise by Inigo Quilez - iq/2013
// https://www.shadertoy.com/view/XdXGW8
float noise2(vec2 st){
    vec2 i=floor(st);
    vec2 f=fract(st);
    
    vec2 u=f*f*(3.-2.*f);
    
    return mix(mix(dot(random2(i+vec2(0.,0.)),f-vec2(0.,0.)),
    dot(random2(i+vec2(1.,0.)),f-vec2(1.,0.)),u.x),
    mix(dot(random2(i+vec2(0.,1.)),f-vec2(0.,1.)),
    dot(random2(i+vec2(1.,1.)),f-vec2(1.,1.)),u.x),u.y);
}

vec2 Rot(vec2 vUv, float a){
    //vUv *= 2.0;
    vUv -= 0.5;
    vUv = mat2(cos(a), -sin(a),
               sin(a), cos(a)) * vUv;
    vUv += 0.5;
    return vUv;
}


float plot(vec2 vUv,float p){
    p *= vUv.x;
    return smoothstep(p +0.15, p, vUv.y) -
           smoothstep(p, p - 0.15, vUv.y);
}

float plot2(vec2 vUv,float p){
    p *= vUv.y;
    return smoothstep(p +0.15, p, vUv.x) -
           smoothstep(p, p - 0.15, vUv.x);
}

float cir(vec2 vUv, vec2 pos, float size){
    return 1. - smoothstep(size, size + 0.01, distance(vUv, pos));
}

void main(){
    vec2 vUv = vec2(vUv.x, vUv.y);
    vUv = vUv * 15. - 7.5;
    vec3 color = vec3(0.);
    vUv = noise2(vUv+u_time) * vUv;
    float y = plot(vUv, sin(u_time+ TWO_PI));
    float y2 = plot2(vUv, cos(u_time+ TWO_PI));
    color = vec3(y);
    gl_FragColor = vec4(color, 1.);
}