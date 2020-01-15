//
//  OpenGLESController.m
//  Xib使用
//
//  Created by 微光星芒 on 2019/3/8.
//  Copyright © 2019 微光星芒. All rights reserved.
//

#import "OpenGLESController.h"
#import <OpenGLES/ES3/gl.h>
#import <OpenGLES/ES3/glext.h>
@interface OpenGLESController (){
    EAGLContext *context;
    GLKBaseEffect *meffect; //着色器或者光照
}


@end

@implementation OpenGLESController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self showImageWitOpenGlES];
    
    
}



-(void)showImageWitOpenGlES{
    [self setUpConfigure];
    [self uploadVertexArray];
    [self uploadTexture];
}

//1.设置配置
-(void)setUpConfigure{
    //新建ES 上下文  相当于一个画板(画布?)
    context = [[EAGLContext alloc]initWithAPI:kEAGLRenderingAPIOpenGLES3];
    if (context == nil) {
        NSLog(@"*******c创建失败");
        return;
    }
    GLKView *view = (GLKView *)self.view;
    view.context = context;
    //颜色设置  rgb 用8位表示
    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    //设置深度
    //更季节
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    //设置当前context
    [EAGLContext setCurrentContext:context];
    
    //开启深度测试 ,让离得近的物体可以遮挡远的物体
    glEnable(GL_DEPTH_TEST);
    
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    
}

//2. 加载顶点数据
- (void)uploadVertexArray{
    
    //gles 只能通过 点 线 和三角形 进行图像渲染
    
    //坐标系 原点在屏幕中间
    GLfloat vertexData[] = {
        
        //前三个指顶点(顶点坐标) 后两个指纹理(纹理坐标)
        //x,y,z    顶点和纹理对应关系  通过  后面两项实现对应
        //opengel的坐标系  屏幕原点为(0,0,0) 此为顶点坐标系
        
        //纹理也有对应的 坐标系
        0.5f,-0.5f,0.0f, 1.0f,0.0f,
        0.f,0.5f,0.0f,   1.0f,1.0f,
        -0.5f,0.5f,0.0f, 0.0f,1.0f,
        
        0.5f,-0.5f,0.0f,  1.0f,0.0f,
        -0.5f,0.5f,0.0f,  0.0f,1.0f,
        -0.5f,-0.5f,0.0f, 0.0f,0.0f,
    };
    

    
    //缓存区
    GLuint buffer;
    
    //申请一个缓存区标识符
    glGenBuffers(1, &buffer);
    
    //这个buffer是用来干什么的
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    
    //把顶点数据从CPU -> 复制到GPU
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);

    //数据要用来交给顶点的
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    
    //
    //第5个参数: 偏移量是多少
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(GLfloat) *5, (GLfloat *)NULL);
    
    //读取纹理
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    //
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) *5, (GLfloat *)NULL + 3);
}

//3. 加载纹理数据
-(void)uploadTexture{
    
    //获取纹理保存路径
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"ic_tabbar" ofType:@"png"];
    
    //2.读取纹理的方式
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@(1),GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithContentsOfFile:filePath options:options error:nil];
    
    //着色器
    meffect = [[GLKBaseEffect alloc]init];
    meffect.texture2d0.enabled = GL_TRUE;
    meffect.texture2d0.name = textureInfo.name;
    
}





@end
