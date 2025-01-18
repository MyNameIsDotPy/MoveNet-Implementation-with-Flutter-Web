let video;
let canvas;
let ctx;
let detector;

async function loadPoseDetector() {

    video = document.getElementById('video-draw');
    canvas = document.getElementById('canvas-draw');

    canvas.width = video.videoWidth;
    canvas.height = video.videoHeight;

    ctx = canvas.getContext('2d');
    detector = await poseDetection.createDetector(poseDetection.SupportedModels.MoveNet, {
        modelType: poseDetection.movenet.modelType.SINGLEPOSE_THUNDER
    });

    console.log('Pose detector loaded')
}

function drawKeypoints(keypoints){
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    keypoints.forEach(
        (keypoint)=>{
            if(keypoint.score>0.5){
                const {x, y} = keypoint;
                ctx.fillStyle = 'red';
                ctx.beginPath();
                ctx.arc(x, y, 10, 0, 2 * Math.PI);
                ctx.fill();
            }
        }
    )
}

async function detectPose(){
    if(!detector){
        await loadPoseDetector();
        //throw new Error('The detector has not been initialized');
    }

    // Pass in a video stream to the model to detect poses.
    const poses = await detector.estimatePoses(video);
    if(poses){
        poses.forEach(
            (pose)=>{
                drawKeypoints(pose.keypoints);
            }
        );
    }
    requestAnimationFrame(detectPose);

}