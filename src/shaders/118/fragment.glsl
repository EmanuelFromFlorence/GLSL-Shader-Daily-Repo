varying vec2 vUv;
#define PI 3.14159265358979323846
#define TWO_PI PI * 2.0
uniform float u_time;

vec2 Tile(vec2 vUv, float zoom){
    vUv *= zoom;
    vUv.x += sin((step(1., mod(vUv.y, 2.0)) * 0.5) * u_time * 0.25);
    vUv.y -= sin((step(1., mod(vUv.x, 2.0)) * 0.25) * u_time);
    // vUv.y += step(1., mod(vUv.x, 4.0)) * sin(u_time);
    //vUv.y += cos(u_time);
    return fract(vUv);
}


float Tri(vec2 vUv, float size){
    vUv -= 0.5;
    float a = atan(vUv.x, vUv.y) + PI;
    float r = TWO_PI/3.0;
    float d = cos(floor(.5 + a/r) * r-a) * length(vUv);
    return 1.0 - smoothstep(size, size+0.01, d);
}

float BoxBorder(vec2 vUv,vec2 size){
    //vUv = vUv * 4. - .5;
    vec2 b=smoothstep(size,size+vec2(.01),vUv);
    b*=smoothstep(size,size+vec2(.01),1.-vUv);
    float box1=b.x*b.y;
    vec2 b2=smoothstep(size-vec2(.01),(size-vec2(.01))+vec2(.01),vUv);
    b2*=smoothstep(size-vec2(.01),(size-vec2(.01))+vec2(.01),1.-vUv);
    float box2=b2.x*b2.y;
    return box2;
}

void main(){
    vec2 vUv = vec2(vUv.x, vUv.y);
    vec3 color = vec3(0.);

    vec2 newUv = vUv; 
    newUv = Tile(newUv,5.0);
    float t1 = Tri(newUv, 0.25);
    color = vec3(t1);

    gl_FragColor = vec4(color, 1.);
}