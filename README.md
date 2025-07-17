# PZXY竞赛管理平台

PZXY内部使用的竞赛管理平台。

需求文档见：

- https://docs.qq.com/doc/DWkxsRGFmdXBac3JY

## 项目结构

采用前后端分离的架构：

- [前端](competition-system-frontend)：Vue3+Vite
- [后端](competition-system-backend)：Java21+Spring Boot+MySQL

## 项目启动

### 后端

0. 修改数据库连接等配置；
1. 进入`competition-system-backend`目录；
2. 初始化MySQL数据库：执行`sql`目录下的建表脚本
3. 安装依赖：`mvn install`
4. 启动项目：`mvn spring-boot:run`

### 前端

1. 进入`competition-system-frontend`目录
2. 安装依赖：`yarn`
3. 启动项目：`yarn dev`

## 说明

开启了分支保护，合并到 `main`、`dev` 分支的代码只有通过PR才能被合并！

**开发过程：**

- 在开发时，基于 `dev` 分支开发；
- 开发完成后，通过PR将各自的分支合并到 `dev` 分支；

**发布过程：**

- 发布时，基于 `main` 分支发布；
- 将 `dev` 分支合并到 `main` 分支进行发布；
