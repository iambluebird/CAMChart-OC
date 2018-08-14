//
//  CAMMacroDefinition.h
//  CAMChartDemo
//
//  Created by 欧阳峰 on 2018/8/9.
//  Copyright © 2018年 欧阳峰. All rights reserved.
//

#ifndef CAMMacroDefinition_h
#define CAMMacroDefinition_h

//弧度转角度
#define CAM_Radians_To_Degrees(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define CAM_Degrees_To_Radians(angle) ((angle) / 180.0 * M_PI)


//XY坐标系中，有效绘制区域距离坐标轴的安全距离，避免贴死坐标轴出现元素重叠的情况
//#define CAM_XYCOORDINATE_SAFE_OFFSET 10.0 //修改为profile里的padding属性进行控制
//XY坐标系中，轴标签与轴之间保留的安全距离，避免重叠
#define CAM_XYCOORDINATE_LABEL_SAVE_OFFSET 5.0

#endif /* CAMMacroDefinition_h */
