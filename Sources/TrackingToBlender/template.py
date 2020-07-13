import bpy
import bpy.types

transforms = ### Camera Data HERE ### #Form of [[x,y,z,rx,ry,rz]]
cam = bpy.data.objects["Camera"]

bpy.context.scene.render.fps = 60
frame = 0
for transform in transforms:
    cam.matrix_world = transform
    cam.keyframe_insert(data_path="location", frame=frame)
    cam.keyframe_insert(data_path="rotation_euler", frame=frame)
    frame = frame+1
