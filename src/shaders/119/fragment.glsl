varying vec2 vUv;
#define PI 3.14159265358979323846
uniform float u_time;

vec2 Tile(vec2 vUv, float zoom){
    vUv *= zoom;
    //vUv.x-=step(1.,mod(vUv.y,2.))+u_time;
    vUv.x += step(1., mod(vUv.y, 2.0)) * (0.5 + u_time);
    
    return fract(vUv);
}

vec2 movingTiles(vec2 _st,float _zoom,float _speed){
    _st*=_zoom;
    float time=u_time*_speed;
    if(fract(time)>.5){
        if(fract(_st.y*.5)>.5){
            _st.x+=fract(time)*2.;
        }else{
            _st.x-=fract(time)*2.;
        }
    }else{
        if(fract(_st.x*.5)>.5){
            _st.y+=fract(time)*2.;
        }else{
            _st.y-=fract(time)*2.;
        }
    }
    return fract(_st);
}

float Cir(vec2 vUv, vec2 pos, float size){
    return 1. - smoothstep(size, size + 0.01, distance(vUv, pos));
}

void main(){
    vec2 vUv = vec2(vUv.x, vUv.y);
    vec3 color = vec3(0.);
    vUv = movingTiles(vUv, 9.0, 0.25);
    float c1 = Cir(vUv, vec2(0.5), 0.25);
    color = vec3(c1);
    gl_FragColor = vec4(color, 1.);
}