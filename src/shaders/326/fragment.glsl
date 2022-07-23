varying vec2 vUv;
#define PI 3.14159265359
#define TWO_PI 6.28318530718
uniform float u_time;
uniform vec2 u_mouse;


//Shaping functions 1.1
//plot from book of shaders

float plot(vec2 st, float pct){
    return smoothstep(pct-0.1, pct, st.y) -
           smoothstep(pct, pct+0.1, st.y);
}

void main(){
    vec2 vUv = vec2(vUv.x, vUv.y);
    gl_FragColor = vec4(vUv, 0., 1.);
}