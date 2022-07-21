varying vec2 vUv;
#define PI 3.14159265359
#define TWO_PI 6.28318530718
uniform float u_time;
uniform vec2 u_mouse;


//Shaping functions 1.1
//plot from book of shaders

float plot(vec2 st){
    return smoothstep(0.05, 0.0, abs(st.y - st.x));
}

void main(){
    vec2 vUv = vec2(vUv.x, vUv.y);
    vec3 color = vec3(0.);
    float y = vUv.x;
    float pct = plot(vUv);
    color = vec3(y);
    color += vec3(pct) * vec3(1.0, .0, .0);
    gl_FragColor = vec4(color, 1.);
}