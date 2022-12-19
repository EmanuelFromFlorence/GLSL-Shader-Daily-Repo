void main()
{
    vec2 vUv = vec2(vUv.x, vUv.y);
    vec3 color = vec3(0.);
    color = vec3(vUv.x, vUv.y, 0.);
    gl_FragColor = vec4(color, 1.);
}