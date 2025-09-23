# System setup


## SMPL body model download
- Look at smpler for more detailed exampels


```
Traceback (most recent call last):
  File "main/inference.py", line 158, in <module>
    main()
  File "main/inference.py", line 150, in main
    vis_img = render_mesh(vis_img, mesh, smpl_x.face, {'focal': focal, 'princpt': princpt}, mesh_as_vertices=False)
  File "/home/leyang/Documents/SMPLest-X/utils/visualization_utils.py", line 185, in render_mesh
    r = pyrender.OffscreenRenderer(viewport_width=img.shape[1],
  File "/home/leyang/.local/lib/python3.8/site-packages/pyrender/offscreen.py", line 31, in __init__
    self._create()
  File "/home/leyang/.local/lib/python3.8/site-packages/pyrender/offscreen.py", line 149, in _create
    self._platform.init_context()
  File "/home/leyang/.local/lib/python3.8/site-packages/pyrender/platforms/osmesa.py", line 19, in init_context
    from OpenGL.osmesa import (
ImportError: cannot import name 'OSMesaCreateContextAttribs' from 'OpenGL.osmesa' (/home/leyang/miniconda3/envs/smplestx/lib/python3.8/site-packages/OpenGL/osmesa/__init__.py)
```
- https://blog.csdn.net/guntangsanjing/article/details/127651381
  - `pip install pyopengl==3.1.4`
  - Solved after suceesfully install


```
[mjpeg @ 0x243625c0] Non full-range YUV is non-standard, set strict_std_compliance to at most unofficial to use it.
[mjpeg @ 0x23dd1500] ff_frame_thread_encoder_init failed
[vost#0:0/mjpeg @ 0x23dd1100] Error while opening encoder - maybe incorrect parameters such as bit_rate, rate, width or height.
Error while filtering: Invalid argument
[out#0/mp4 @ 0x23dc9040] Nothing was written into output file, because at least one of its streams received no packets.
```
- FFMPEG issue
    ```
    conda remove ffmpeg
    conda install -c conda-forge "ffmpeg[build=*gpl*]"
    ```

```
Traceback (most recent call last):
  File "main/inference.py", line 158, in <module>
    main()
  File "main/inference.py", line 110, in main
    yolo_bbox_xywh[0] = yolo_bbox[bbox_id][0]
IndexError: index 0 is out of bounds for axis 0 with size 0
ffmpeg version 7.1 Copyright (c) 2000-2024 the FFmpeg developers
  built with gcc 13.3.0 (conda-forge gcc 13.3.0-1)
  configuration: --prefix=/home/leyang/miniconda3/envs/smplestx --cc=/home/conda/feedstock_root/build_artifacts/ffmpeg_1728332263724/_build_env/bin/x86_64-conda-linux-gnu-cc --cxx=/home/conda/feedstock_root/build_artifacts/ffmpeg_1728332263724/_build_env/bin/x86_64-conda-linux-gnu-c++ --nm=/home/conda/feedstock_root/build_artifacts/ffmpeg_1728332263724/_build_env/bin/x86_64-conda-linux-gnu-nm --ar=/home/conda/feedstock_root/build_artifacts/ffmpeg_1728332263724/_build_env/bin/x86_64-conda-linux-gnu-ar --disable-doc --enable-openssl --enable-demuxer=dash --enable-hardcoded-tables --enable-libfreetype --enable-libharfbuzz --enable-libfontconfig --enable-libopenh264 --enable-libdav1d --disable-gnutls --enable-libmp3lame --enable-libvpx --enable-libass --enable-pthreads --enable-vaapi --enable-libopenvino --enable-gpl --enable-libx264 --enable-libx265 --enable-libaom --enable-libsvtav1 --enable-libxml2 --enable-pic --enable-shared --disable-static --enable-version3 --enable-zlib --enable-libopus --pkg-config=/home/conda/feedstock_root/build_artifacts/ffmpeg_1728332263724/_build_env/bin/pkg-config
```

