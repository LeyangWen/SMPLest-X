import os
import os.path as osp
import argparse
import numpy as np
import torchvision.transforms as transforms
import torch.backends.cudnn as cudnn
import torch
import cv2
import datetime
import pickle

from tqdm import tqdm
from pathlib import Path
from human_models.human_models import SMPLX
from ultralytics import YOLO
from main.base import Tester
from main.config import Config
from utils.data_utils import load_img, process_bbox, generate_patch_image
from utils.visualization_utils import render_mesh
from utils.inference_utils import non_max_suppression


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--num_gpus', type=int, dest='num_gpus')
    parser.add_argument('--file_name', type=str, default='test')
    parser.add_argument('--ckpt_name', type=str, default='model_dump')
    parser.add_argument('--start', type=str, default=1)
    parser.add_argument('--end', type=str, default=1)
    parser.add_argument('--multi_person', action='store_true')
    parser.add_argument('--fps', type=int, default=20)
    parser.add_argument('--output_path', type=str, default='./demo/result_test.pkl')
    parser.add_argument('--skip_render', action='store_true')
    args = parser.parse_args()
    print("args.skip_render:", args.skip_render)
    return args

def main():
    print("#"*60)
    print("Starting inference...")
    args = parse_args()
    cudnn.benchmark = True
    
    # marker_vids={'smpl': {'HDTP': 411, 'REAR': 3941, 'LEAR': 517, 'MDFH': 335, 'C7': 829, 'C7_d': 1305, 'SS': 3171, 'T8': 3024, 'XP': 3077, 'RPSIS': 5246, 'RASIS': 6573, 'LPSIS': 1781, 'LASIS': 3156, 'RAP': 4721, 'RAP_b': 5283, 'RAP_f': 5354, 'LAP': 1238, 'LAP_b': 2888, 'LAP_f': 1317, 'RLE': 5090, 'RME': 5202, 'LLE': 1621, 'LME': 1732, 'RRS': 5573, 'RUS': 5568, 'LRS': 2112, 'LUS': 2108, 'RMCP2': 5595, 'RMCP5': 5636, 'LMCP2': 2135, 'LMCP5': 2290, 'RIC': 5257, 'RGT': 4927, 'LIC': 1794, 'LGT': 1454, 'RMFC': 4842, 'RLFC': 4540, 'LMFC': 1369, 'LLFC': 1054, 'RMM': 6832, 'RLM': 6728, 'LMM': 3432, 'LLM': 3327, 'RMTP1': 6739, 'RMTP5': 6745, 'LMTP1': 3337, 'LMTP5': 3344, 'RHEEL': 6786, 'LHEEL': 3387},
    #               'smplh': {'HDTP': 411, 'REAR': 3941, 'LEAR': 517, 'MDFH': 335, 'C7': 829, 'C7_d': 1305, 'SS': 3171, 'T8': 3024, 'XP': 3077, 'RPSIS': 5246, 'RASIS': 6573, 'LPSIS': 1781, 'LASIS': 3156, 'RAP': 4721, 'RAP_b': 5283, 'RAP_f': 5354, 'LAP': 1238, 'LAP_b': 2888, 'LAP_f': 1317, 'RLE': 5090, 'RME': 5202, 'LLE': 1621, 'LME': 1732, 'RRS': 5573, 'RUS': 5568, 'LRS': 2112, 'LUS': 2108, 'RMCP2': 5595, 'RMCP5': 5636, 'LMCP2': 2135, 'LMCP5': 2290, 'RIC': 5257, 'RGT': 4927, 'LIC': 1794, 'LGT': 1454, 'RMFC': 4842, 'RLFC': 4540, 'LMFC': 1369, 'LLFC': 1054, 'RMM': 6832, 'RLM': 6728, 'LMM': 3432, 'LLM': 3327, 'RMTP1': 6739, 'RMTP5': 6745, 'LMTP1': 3337, 'LMTP5': 3344, 'RHEEL': 6786, 'LHEEL': 3387},
    #               'smplx': {'HDTP': 9011, 'REAR': 1050, 'LEAR': 560, 'MDFH': 8949, 'C7': 3353, 'C7_d': 5349, 'SS': 5533, 'T8': 5495, 'XP': 5534, 
    #                         'RPSIS': 7141, 'RASIS': 8421, 'LPSIS': 4405, 'LASIS': 5727, 'RAP': 6175, 'RAP_b': 6632, 'RAP_f': 7253, 'LAP': 3414, 'LAP_b': 4431, 'LAP_f': 4517, 
    #                         'RLE': 6695, 'RME': 7107, 'LLE': 4251, 'LME': 4371, 'RRS': 7462, 'RUS': 7458, 'LRS': 4726, 'LUS': 4722, 'RMCP2': 7483, 'RMCP5': 7525, 'LMCP2': 4747, 'LMCP5': 4788, 'RIC': 7149, 'RGT': 6832, 'LIC': 4413, 'LGT': 4088, 'RMFC': 6747, 'RLFC': 6445, 'LMFC': 3999, 'LLFC': 3684, 'RMM': 8680, 'RLM': 8576, 'LMM': 8892, 'LLM': 5882, 'RMTP1': 8587, 'RMTP5': 8593, 'LMTP1': 5893, 'LMTP5': 5899, 'RHEEL': 8634, 'LHEEL': 8846}}
    marker_vids_V2={'smpl': {'HDTP': 411, 'REAR': 3941, 'LEAR': 517, 'MDFH': 335, 'C7': 829, 'C7_d': 1305, 'SS': 3171, 'T8': 3024, 'XP': 3077, 'RPSIS': 5246, 'RASIS': 6573, 'LPSIS': 1781, 'LASIS': 3156, 'RAP': 4721, 'RAP_b': 5283, 'RAP_f': 5354, 'LAP': 1238, 'LAP_b': 2888, 'LAP_f': 1317, 'RLE': 5090, 'RME': 5202, 'LLE': 1621, 'LME': 1732, 'RRS': 5573, 'RUS': 5568, 'LRS': 2112, 'LUS': 2108, 'RMCP2': 5595, 'RMCP5': 5636, 'LMCP2': 2135, 'LMCP5': 2290, 'RIC': 5257, 'RGT': 4927, 'LIC': 1794, 'LGT': 1454, 'RMFC': 4842, 'RLFC': 4540, 'LMFC': 1369, 'LLFC': 1054, 'RMM': 6832, 'RLM': 6728, 'LMM': 3432, 'LLM': 3327, 'RMTP1': 6739, 'RMTP5': 6745, 'LMTP1': 3337, 'LMTP5': 3344, 'RHEEL': 6786, 'LHEEL': 3387},
                  'smplh': {'HDTP': 411, 'REAR': 3941, 'LEAR': 517, 'MDFH': 335, 'C7': 829, 'C7_d': 1305, 'SS': 3171, 'T8': 3024, 'XP': 3077, 'RPSIS': 5246, 'RASIS': 6573, 'LPSIS': 1781, 'LASIS': 3156, 'RAP': 4721, 'RAP_b': 5283, 'RAP_f': 5354, 'LAP': 1238, 'LAP_b': 2888, 'LAP_f': 1317, 'RLE': 5090, 'RME': 5202, 'LLE': 1621, 'LME': 1732, 'RRS': 5573, 'RUS': 5568, 'LRS': 2112, 'LUS': 2108, 'RMCP2': 5595, 'RMCP5': 5636, 'LMCP2': 2135, 'LMCP5': 2290, 'RIC': 5257, 'RGT': 4927, 'LIC': 1794, 'LGT': 1454, 'RMFC': 4842, 'RLFC': 4540, 'LMFC': 1369, 'LLFC': 1054, 'RMM': 6832, 'RLM': 6728, 'LMM': 3432, 'LLM': 3327, 'RMTP1': 6739, 'RMTP5': 6745, 'LMTP1': 3337, 'LMTP5': 3344, 'RHEEL': 6786, 'LHEEL': 3387},
                  'smplx': {'HDTP': 9011, 'REAR': 1050, 'LEAR': 560, 'MDFH': 8949, 'C7': 3353, 'C7_d': 5349, 'SS': 5533, 'T8': 5495, 'XP': 5534, 
                            'RPSIS': 7141, 'RASIS': 8421, 'LPSIS': 4405, 'LASIS': 5727, 'RAP': 6175, 'RAP_b': 6632, 'RAP_f': 7253, 'LAP': 3414, 'LAP_b': 4431, 'LAP_f': 4517, 
                            'RLE': 7260, 'RME': 7107, 'LLE': 4251, 'LME': 4371, 'RRS': 7462, 'RUS': 7458, 'LRS': 4726, 'LUS': 4722, 'RMCP2': 7483, 'RMCP5': 7525, 'LMCP2': 4747, 'LMCP5': 4788, 'RIC': 7149, 'RGT': 6832, 'LIC': 4413, 'LGT': 4088, 'RMFC': 6747, 'RLFC': 6445, 'LMFC': 3999, 'LLFC': 3684, 'RMM': 8680, 'RLM': 8576, 'LMM': 8892, 'LLM': 5882, 'RMTP1': 8587, 'RMTP5': 8593, 'LMTP1': 5893, 'LMTP5': 5899, 'RHEEL': 8634, 'LHEEL': 8846}}
    
    marker_vids = marker_vids_V2  # use V2 with corrected RLE index
    vid = marker_vids['smplx']
    name_list = list(vid.keys())
    idx_list = list(vid.values())
    # idx_list[0:8] = [7075, 7260, 7076, 7259, 7254, 7110, 7077, 7032 ]

    # init config
    time_str = datetime.datetime.now().strftime('%Y%m%d_%H%M%S')
    root_dir = Path(__file__).resolve().parent.parent
    config_path = osp.join('./pretrained_models', args.ckpt_name, 'config_base.py')
    cfg = Config.load_config(config_path)
    checkpoint_path = osp.join('./pretrained_models', args.ckpt_name, f'{args.ckpt_name}.pth.tar')
    img_folder = osp.join(root_dir, 'demo', 'input_frames', args.file_name)
    output_folder = osp.join(root_dir, 'demo', 'output_frames', args.file_name)
    os.makedirs(output_folder, exist_ok=True)
    exp_name = f'inference_{args.file_name}_{args.ckpt_name}_{time_str}'

    new_config = {
        "model": {
            "pretrained_model_path": checkpoint_path,
        },
        "log":{
            'exp_name':  exp_name,
            'log_dir': osp.join(root_dir, 'outputs', exp_name, 'log'),  
            }
    }
    cfg.update_config(new_config)
    cfg.prepare_log()
    
    # init human models
    smpl_x = SMPLX(cfg.model.human_model_path)

    # init tester
    demoer = Tester(cfg)
    demoer.logger.info(f"Using 1 GPU.")
    demoer.logger.info(f'Inference [{args.file_name}] with [{cfg.model.pretrained_model_path}].')
    demoer._make_model()

    # init detector
    bbox_model = getattr(cfg.inference.detection, "model_path", 
                        './pretrained_models/yolov8x.pt')
    detector = YOLO(bbox_model)

    start = int(args.start)
    end = int(args.end) + 1

    poses_list = []   # list of (159,) axis-angle vectors, exclude eyes, smplx
    trans_list = []   # list of (3,) translations
    smplx_joint_cam_list = []  # list of (133,3) joints in camera space
    VEHS_surface_kpts_list = []
    
    for frame in tqdm(range(start, end)):
        
        # prepare input image
        img_path =osp.join(img_folder, f'{int(frame):06d}.jpg')

        transform = transforms.ToTensor()
        original_img = load_img(img_path)
        vis_img = original_img.copy()
        original_img_height, original_img_width = original_img.shape[:2]
        
        # detection, xyxy
        yolo_bbox = detector.predict(original_img, 
                                device='cuda', 
                                classes=00, 
                                conf=cfg.inference.detection.conf, 
                                save=cfg.inference.detection.save, 
                                verbose=cfg.inference.detection.verbose
                                    )[0].boxes.xyxy.detach().cpu().numpy()

        if len(yolo_bbox)<1:
            # save original image if no bbox
            num_bbox = 0
        elif not args.multi_person:
            # only select the largest bbox
            num_bbox = 1
            # yolo_bbox = yolo_bbox[0]
        else:
            # keep bbox by NMS with iou_thr
            yolo_bbox = non_max_suppression(yolo_bbox, cfg.inference.detection.iou_thr)
            num_bbox = len(yolo_bbox)

        # loop all detected bboxes
        for bbox_id in range(num_bbox):
            yolo_bbox_xywh = np.zeros((4))
            yolo_bbox_xywh[0] = yolo_bbox[bbox_id][0]
            yolo_bbox_xywh[1] = yolo_bbox[bbox_id][1]
            yolo_bbox_xywh[2] = abs(yolo_bbox[bbox_id][2] - yolo_bbox[bbox_id][0])
            yolo_bbox_xywh[3] = abs(yolo_bbox[bbox_id][3] - yolo_bbox[bbox_id][1])
            
            # xywh
            bbox = process_bbox(bbox=yolo_bbox_xywh, 
                                img_width=original_img_width, 
                                img_height=original_img_height, 
                                input_img_shape=cfg.model.input_img_shape, 
                                ratio=getattr(cfg.data, "bbox_ratio", 1.25))                
            img, _, _ = generate_patch_image(cvimg=original_img, 
                                                bbox=bbox, 
                                                scale=1.0, 
                                                rot=0.0, 
                                                do_flip=False, 
                                                out_shape=cfg.model.input_img_shape)
                
            img = transform(img.astype(np.float32))/255
            img = img.cuda()[None,:,:,:]
            inputs = {'img': img}
            targets = {}
            meta_info = {}

            # mesh recovery
            with torch.no_grad():
                out = demoer.model(inputs, targets, meta_info, 'test')  # dict_keys(['img', 'smplx_joint_proj', 'smplx_mesh_cam', 'smplx_root_pose', 'smplx_body_pose', 'smplx_lhand_pose', 'smplx_rhand_pose', 'smplx_jaw_pose', 'smplx_shape', 'smplx_expr', 'cam_trans', 'smplx_joint_cam'])
            mesh = out['smplx_mesh_cam'].detach().cpu().numpy()[0] #(10475, 3)

            # render mesh
            focal = [cfg.model.focal[0] / cfg.model.input_body_shape[1] * bbox[2], 
                     cfg.model.focal[1] / cfg.model.input_body_shape[0] * bbox[3]]
            princpt = [cfg.model.princpt[0] / cfg.model.input_body_shape[1] * bbox[2] + bbox[0], 
                       cfg.model.princpt[1] / cfg.model.input_body_shape[0] * bbox[3] + bbox[1]]
            
            if not args.skip_render:
                # draw the bbox on img
                vis_img = cv2.rectangle(vis_img, (int(yolo_bbox[bbox_id][0]), int(yolo_bbox[bbox_id][1])), 
                                        (int(yolo_bbox[bbox_id][2]), int(yolo_bbox[bbox_id][3])), (0, 255, 0), 1)
                # draw mesh
                vis_img = render_mesh(vis_img, mesh, smpl_x.face, {'focal': focal, 'princpt': princpt}, mesh_as_vertices=False)

            
            ### Save results in pkl (Wen):
            if num_bbox > 1:
                print(f"Frame {frame}: Detected {num_bbox} persons, only saving bbox {bbox_id} in results.")
            if bbox_id == 0:
                root = out['smplx_root_pose']   # (1, 3)
                body = out['smplx_body_pose']   # (1, 63)
                lhd  = out['smplx_lhand_pose']  # (1, 45)
                rhd  = out['smplx_rhand_pose']  # (1, 45)
                jaw  = out['smplx_jaw_pose']    # (1, 3)
                smplx_joint_cam = out['smplx_joint_cam']  # (1, 133, 3)  # actually 137 instead of 133
                
                VEHS_surface_kpts = mesh[idx_list, :]  # 49, 3

                pelvis   = smplx_joint_cam[:, 0, :]    # (1,3), always is (0,0,0)
                trans = pelvis  # just set to 0
                # print(trans.shape)
                pose_vec = torch.cat([root, body, lhd, rhd, jaw], dim=-1).squeeze(0).detach().cpu().numpy()  # (159,)
                trans_vec = trans.squeeze(0).detach().cpu().numpy()                                          # (3,)
                smplx_joint_cam = smplx_joint_cam.squeeze(0).detach().cpu().numpy()                          # (133, 3)
                # raise NotImplementedError
                poses_list.append(pose_vec)
                trans_list.append(trans_vec)
                smplx_joint_cam_list.append(smplx_joint_cam)
                VEHS_surface_kpts_list.append(VEHS_surface_kpts)
                
        # If nothing was appended for this frame, add NaNs to keep T consistent
        if len(poses_list) < (frame - start + 1):
            poses_list.append(np.full((159,), np.nan, dtype=np.float32))
            trans_list.append(np.full((3,),   np.nan, dtype=np.float32))
            smplx_joint_cam_list.append(np.full((137, 3), np.nan, dtype=np.float32))
            VEHS_surface_kpts_list.append(np.full((49, 3), np.nan, dtype=np.float32))
            print(f"Frame {frame}: No valid detections, appending NaNs to results.")

            

        if not args.skip_render:
            # save rendered image
            frame_name = os.path.basename(img_path)
            cv2.imwrite(os.path.join(output_folder, frame_name), vis_img[:, :, ::-1])
    
    poses = np.stack(poses_list, axis=0)  # (T, 159)
    trans = np.stack(trans_list, axis=0)  # (T, 3)
    smplx_joints_cam = np.stack(smplx_joint_cam_list, axis=0)  # (T, 133, 3)
    VEHS_surface_kpts = np.stack(VEHS_surface_kpts_list, axis=0)  # (T, 49, 3)

    required_params = {
        "poses": poses,
        "trans": trans,
        "smplx_joints_cam": smplx_joints_cam,
        "VEHS_surface_kpts": VEHS_surface_kpts,
        "fps": args.fps
    }
    
    # save VEHS_surface_kpts to npy
    with open(args.output_path.replace('.pkl', '_markers.npy'), 'wb') as f:
        np.save(f, VEHS_surface_kpts)

    with open(args.output_path, "wb") as f:
        pickle.dump(required_params, f, protocol=pickle.HIGHEST_PROTOCOL)

    print(f"[OK] Wrote poses/trans/fps for {poses.shape[0]} frames to {args.output_path}")


if __name__ == "__main__":
    main()
