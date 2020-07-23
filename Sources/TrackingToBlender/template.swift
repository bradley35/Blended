let PYTHON_TEMPLATE = """
import bpy
import bpy.types
from mathutils import Matrix

transforms = ### Camera Data HERE ### #Form of [[x,y,z,rx,ry,rz]]
cam = bpy.data.objects["Camera"]
bpy.data.cameras.values()[0].lens = 31

bpy.context.scene.render.fps = 60
frame = 0
for transform in transforms:
    cam.matrix_world = transform
    cam.keyframe_insert(data_path="location", frame=frame)
    cam.keyframe_insert(data_path="rotation_euler", frame=frame)
    frame = frame+1
bpy.context.scene.frame_end = frame - 1
print("Successfully imported tracking data")
"""
