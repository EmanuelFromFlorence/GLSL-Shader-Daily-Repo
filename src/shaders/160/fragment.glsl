varying vec2 vUv;
#define PI 3.14159265358979323846
uniform float u_time;
uniform float u_rand;

//rand
float rand(float x){
    return fract(sin(x)* 1e4);
}

float rand(vec2 vUv){
    return fract(sin(dot(vUv.xy, vec2(25. * u_rand, 98. * u_rand))) * 2347081. * u_rand);
}

//bookofshaders
vec2 tPattern(vec2 vUv, float i){
    i = fract((i - 0.5) * 2.0);
    if(i > 0.75){
        vUv = vec2(1.0) - vUv;
    } else if (i > 0.5){
        vUv = vec2(1.0 - vUv.x, vUv.y);
    } else if (i > 0.25){
        vUv = 1.0 - vec2(1.0 - vUv.x, vUv.y);
    }
    return vUv;
}

//plot function
float plot(vec2 vUv, float p){
    return smoothstep(p - 0.075, p, vUv.y) -
           smoothstep(p, p + 0.075, vUv.y);
}

float plot2(vec2 vUv, float p){
    return smoothstep(p - 0.075, p, vUv.x) -
           smoothstep(p, p + 0.075, vUv.x);
}


void main(){
    vec2 vUv = vec2(vUv.x, vUv.y);
    vec3 color = vec3(0.);
    vUv *= 1.;
    float y = sin(plot(vUv, u_rand)) * 500.;
    float x = sin(plot2(vUv, u_rand)) * 500.;
    color = vec3(y + x);
    gl_FragColor = vec4(color, 1.);
}