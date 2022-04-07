import './style.css'
import * as THREE from "three"
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls.js"
import fragment from './Shaders/219/fragment.glsl'
import vertex from './Shaders/219/vertex.glsl'
const canvas = document.querySelector('.webgl')

class NewScene{
    constructor(){
        this._Init()
    }
    
    _Init(){
        this.scene = new THREE.Scene()
        this.time = new THREE.Clock()
        this.num = Math.random()
        //console.log(this.time.getElapsedTime())
        this.oldTime = 0
        //this.InitTextShader()
        this.InitShader()
        this.InitCamera()
        //this.InitLights()
        this.InitRenderer()
        //this.InitControls()
        this.Update()
        window.addEventListener('resize', () => {
            this.Resize()
        })
    }

    InitTextShader(){
        this.fontLoader = new THREE.FontLoader()
        this.fontLoader.load(
            'Sunf_Bold.json',
            (font) => {
                this.textParameters = {
                    font: font,
                    size: 2.0,
                    height: 0.5,
                    curveSegments: 12,
                    bevelEnabled: true,
                    bevelThickness: 0.03,
                    bevelSize: 0.02,
                    bevelOffset: 0,
                    bevelSegments: 5
                }
                this.textGeometry = new THREE.TextGeometry(
                    '200',
                    this.textParameters
                )
                this.textMaterial = new THREE.ShaderMaterial({
                    transparent: true,
                    side: THREE.DoubleSide,
                    vertexShader: vertex,
                    fragmentShader: fragment,
                    uniforms: {
                        u_time: { value: 1.0 },
                        u_rand: { value: 0},
                        u_resolution: { type: "v2", value: new THREE.Vector2() },
                        u_mouse: { type: "v2", value: new THREE.Vector2() }
                    } 
                })
                console.log(fragment)
                this.textMesh = new THREE.Mesh(this.textGeometry, this.textMaterial)
                this.scene.add(this.textMesh)
                this.textGeometry.computeBoundingBox()
                this.textGeometry.center()
            }
        )
    }

    InitShader(){
        //this.geometry = new THREE.BoxGeometry(2, 2, 2)
        this.geometry = new THREE.PlaneBufferGeometry(2, 2)
        this.material = new THREE.ShaderMaterial({
            transparent: true,
            side: THREE.DoubleSide,
            vertexShader: vertex,
            fragmentShader: fragment,
            uniforms: {
                u_time: { type: "f", value: 1.0 },
                u_rand: { value: 0},
                u_resolution: { type: "v2", value: new THREE.Vector2() },
                u_mouse: { type: "v2", value: new THREE.Vector2() }
            } 
        })
        console.log(fragment)
        this.mesh = new THREE.Mesh(this.geometry, this.material)
        this.scene.add(this.mesh)
        document.onmousemove = (e) => {
            this.material.uniforms.u_mouse.value.x = e.pageX
            this.material.uniforms.u_mouse.value.y = e.pageY
        }  
    }

    InitCamera(){
        this.camera = new THREE.PerspectiveCamera(50, window.innerWidth/window.innerHeight, 0.1, 100)
        this.camera.position.z = 3
        this.scene.add(this.camera)
    }

    InitLights(){
        this.ambientLight = new THREE.AmbientLight(0xffffff, 0.5)
        this.scene.add(this.ambientLight)
    }

    InitRenderer(){
        this.renderer = new THREE.WebGLRenderer({
            canvas,
            antialias: true,
        })
        this.renderer.shadowMap.enabled = true
        this.renderer.shadowMap.type = THREE.PCFSoftShadowMap
        this.renderer.setClearColor(0x001219)
        this.renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
        this.renderer.setSize(window.innerWidth, window.innerHeight)
        this.renderer.render(this.scene, this.camera)
        this.renderer.outputEncoding = THREE.sRGBEncoding
        
    }

    InitControls(){
        this.controls = new OrbitControls(this.camera, canvas)
        this.controls.enableDamping = true
        this.controls.update()
        //this.controls.autoRotate = true
    }

    InitTime(){
        this.time = new THREE.Clock()
        
    }

    Resize(){
        this.camera.aspect = window.innerWidth / window.innerHeight
        this.camera.updateProjectionMatrix()
        this.renderer.setSize(window.innerWidth, window.innerHeight)
        //this.textMaterial.uniforms.u_resolution.value.x = canvas.width
        //this.textMaterial.uniforms.u_resolution.value.y = canvas.height
        //console.log(this.material.uniforms.u_resolution.value)
    }

    Update(){
        requestAnimationFrame(() => {
            this.elapsedTime = this.time.getElapsedTime()
            //console.log(this.elapsedTime)
            
            this.deltaTime = this.elapsedTime - this.oldTime
            this.oldTime = this.elapsedTime
            //this.controls.update()
            this.material.uniforms.u_time.value += this.deltaTime
            if (this.textMaterial){
                this.textMaterial.uniforms.u_time.value += this.deltaTime
                //this.textMesh.rotation.y += 0.005
                
            }
            
            this.interval = setInterval(() => {
                clearInterval()
                this.num = Math.random()
            }, 1000)
            
            //this.material.uniforms.u_rand.value = this.num 
            this.renderer.render(this.scene, this.camera)
            this.Update()
        })  
    }
}

let _APP = null

window.addEventListener('DOMContentLoaded', () => {
    _APP = new NewScene()
})
