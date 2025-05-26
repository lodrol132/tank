import * as THREE from 'three';
import { GLTFLoader } from 'three/addons/loaders/GLTFLoader.js';
console.log(THREE, GLTFLoader)


const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );

const renderer = new THREE.WebGLRenderer();
renderer.setSize( window.innerWidth, window.innerHeight );


document.body.appendChild( renderer.domElement );






const ambientLight = new THREE.AmbientLight(0xffffff, 0.8);
scene.add(ambientLight);

const directionalLight = new THREE.DirectionalLight(0xffffff, 1);
directionalLight.position.set(10, 10, 10);
scene.add(directionalLight);





const geometry = new THREE.BoxGeometry( 1, 1, 1 );
const material = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
const cube = new THREE.Mesh( geometry, material );
cube.position.x = 2

//scene.add( cube );





camera.position.z = 5;

const materialLine = new THREE.LineBasicMaterial( { color: "red" } );

const points = [];
points.push( new THREE.Vector3( -1, 0, 0 ) );
points.push( new THREE.Vector3( 0, 1, 0 ) );
points.push( new THREE.Vector3( 1, 0, 0 ) );
points.push( new THREE.Vector3( 0, -1, 0 ) );
points.push( new THREE.Vector3( -1, 0, 0 ) );


const geometryLine = new THREE.BufferGeometry().setFromPoints( points );

const line = new THREE.Line( geometryLine, materialLine );
//scene.add( line );


const geometryCube2 = new THREE.BoxGeometry(2,1,2);
const materialCube2 = new THREE.MeshBasicMaterial( { color: 0x00ff00 } );
const cube2 = new THREE.Mesh( geometryCube2, materialCube2 );
cube2.position.x = -2
//scene.add( cube2 );


const loader = new GLTFLoader();
let model;

loader.load('./files/t-14_armata.glb', (object)=> {
  model = object.scene
  scene.add(model)

  model.position.set(0.5,-3.2,-4)
  model.scale.set(0.15,0.15,0.15)
},
(xhr)=>{
  console.log((xhr.loaded / xhr.total * 100) + '% loaded');


}, 
(error)=>{
  console.log("Ошибка загрузки модели", error);
}

);

let isDragging = false;
let previousMousePosition = {
    x: 0,
    y: 0
};

const canvas = renderer.domElement;

// Обработчики событий мыши
canvas.addEventListener('mousedown', (e) => {
    isDragging = true;
    previousMousePosition = {
        x: e.clientX,
        y: e.clientY
    };
});

canvas.addEventListener('mousemove', (e) => {
    if (!isDragging) return;

    const deltaMove = {
        x: e.clientX - previousMousePosition.x,
        y: e.clientY - previousMousePosition.y
    };

    if (model) {
        // Вращение вокруг осей Y и X
        model.rotation.y += deltaMove.x * 0.01;
        model.rotation.x += deltaMove.y * 0.01;
    }

    previousMousePosition = {
        x: e.clientX,
        y: e.clientY
    };
});

canvas.addEventListener('mouseup', () => {
    isDragging = false;
});

canvas.addEventListener('mouseleave', () => {
    isDragging = false;
});

function animate() {
    cube2.rotation.x += 0.01;
    cube2.rotation.y += 0.01;

    cube.rotation.x += 0.01;
    cube.rotation.y += 0.01;
  renderer.render( scene, camera, );
}
renderer.setAnimationLoop( animate );





const gSphere = new THREE.sphereGeometry(1)
const mSphere = new THREE.MeshBasicMaterial({color: "rgb(0,255,0)"})
const sphere = new THREE.Mesh(gSphere, mSphere)
//scene.add(sphere);